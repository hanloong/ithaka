require 'spec_helper'

describe IdeasController do
  before :each do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project, organisation: @user.organisation)
    sign_in @user
  end

  describe 'GET "new"' do
    it 'should be successful' do
      get :new, project_id: @project.id
      expect(response).to be_success
    end
  end

  describe 'GET "show"' do
    it 'should find the idea' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      get :show, project_id: @project.id, id: idea.id
      expect(assigns(:idea)).to eq(idea)
    end

    it 'should default to visible comments' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      FactoryGirl.create(:comment, idea: idea, user: @user)
      FactoryGirl.create(:comment, idea: idea, user: @user, hidden: true)
      get :show, project_id: @project.id, id: idea.id
      expect(assigns(:comments)).to eq(idea.comments.visible)
    end

    it 'should show all comments if asked' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      FactoryGirl.create(:comment, idea: idea, user: @user)
      FactoryGirl.create(:comment, idea: idea, user: @user, hidden: true)
      get :show, project_id: @project.id, id: idea.id, hidden: true
      expect(assigns(:comments)).to eq(idea.comments)
    end

    it 'should redirect if project not yours' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      Project.any_instance.stub(:has_access?).and_return(false)
      get :show, project_id: @project.id, id: idea.id
      expect(response).to redirect_to projects_path
    end
  end

  describe 'GET "edit"' do
    it 'should find the idea' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      get :edit, project_id: @project.id, id: idea.id
      expect(assigns(:idea)).to eq(idea)
    end
  end

  describe 'POST "create"' do
    it 'should create the idea with valid input' do
      expect do
        post :create, project_id: @project.id,
                      idea: { user_id: @user.id,
                              project_id: @project.id,
                              name: 'Name',
                              description: 'Test',
                              status: :discussing }
      end.to change { Idea.count }.by(1)
    end

    it 'should create the idea' do
      post :create, project_id: @project.id,
                    idea: { project_id: @project.id,
                            name: 'Name',
                            description: 'Test',
                            status: :discussing }
      expect(response).to render_template :new
    end
  end

  describe 'PUT "update"' do
    before :each do
      @idea = FactoryGirl.create(:idea, project: @project, user: @user)
    end

    it 'should update the idea with valid input' do
      put :update, id: @idea.id, project_id: @project.id,
                   idea: {
                     id: @idea.id,
                     user_id: @user.id,
                     project_id: @project.id,
                     name: 'New Name', description: 'Test'
          }
      @idea.reload
      expect(@idea.name).to eq('New Name')
    end

    it 'should not create the idea' do
      put :update, id: @idea.id, project_id: @project.id, idea: { name: '' }
      expect(response).to render_template :edit
    end
  end

  it 'should delete a valid idea' do
    @idea = FactoryGirl.create(:idea, project: @project, user: @user)
    expect do
      delete :destroy, id: @idea.id, project_id: @project.id
    end.to change { Idea.count }.by(-1)
  end

  describe 'GET "unlock"' do
    it 'should unlock votes for the idea if owner' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      @user.update(role: :owner)
      Timecop.freeze(Date.today - 1) do
        (1..4).each do |i|
          user = FactoryGirl.create(:user, email: "test#{i}@email.com")
          FactoryGirl.create(:vote, idea: idea, user: user)
        end
      end

      expect do
        get :unlock, project_id: @project.id, id: idea.id
      end.to change{
        Idea.first.votes.sample.unlocked?
      }.from(false).to(true)
    end

    it 'should not unlock votes for the idea if not an owner' do
      @user.update(role: :user)
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      Timecop.freeze(Date.today - 1) do
        (1..4).each do |i|
          user = FactoryGirl.create(:user, email: "test#{i}@email.com")
          FactoryGirl.create(:vote, idea: idea, user: user)
        end
      end

      expect do
        get :unlock, project_id: @project.id, id: idea.id
      end.not_to change{
        Idea.first.votes.sample.unlocked?
      }
    end
  end

  describe 'GET "release"' do
    it 'should delete votes for the idea if owner' do
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      @user.update(role: :owner)
      Timecop.freeze(Date.today - 1) do
        (1..4).each do |i|
          user = FactoryGirl.create(:user, email: "test#{i}@email.com")
          FactoryGirl.create(:vote, idea: idea, user: user)
        end
      end

      expect do
        get :release, project_id: @project.id, id: idea.id
      end.to change{
        idea.votes.count
      }.from(4).to(0)
    end

    it 'should not release votes for the idea if not an owner' do
      @user.update(role: :user)
      idea = FactoryGirl.create(:idea, project: @project, user: @user)
      Timecop.freeze(Date.today - 1) do
        (1..4).each do |i|
          user = FactoryGirl.create(:user, email: "test#{i}@email.com")
          FactoryGirl.create(:vote, idea: idea, user: user)
        end
      end

      expect do
        get :release, project_id: @project.id, id: idea.id
      end.not_to change{
        idea.votes.count
      }
    end
  end
end
