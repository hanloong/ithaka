require 'spec_helper'

describe Project do
  before :each do
    @org = FactoryGirl.create(:organisation)
    @attr = {
      name: 'Make money',
      description: 'For reals',
      organisation: @org
    }
  end

  it 'should create a project with valid attributes' do
    expect(Project.new(@attr)).to be_valid
  end

  it 'requires a name' do
    @attr[:name] = nil
    expect(Project.new(@attr)).not_to be_valid
  end

  it 'requires a description' do
    @attr[:description] = nil
    expect(Project.new(@attr)).not_to be_valid
  end

  context 'when there are many projects' do
    before :each do
      ActiveRecord::Base.transaction do
        Project.create(@attr)
        org2 = FactoryGirl.create(:organisation)
        Project.create(name: 'Public',
                       description: 'Project',
                       public: true,
                       organisation_id: org2.id
                      )
        Project.create(name: 'Private',
                       description: 'Project',
                       public: false,
                       organisation_id: org2.id
                      )
      end
    end

    it 'should return available projects' do
      expect(Project.available(@org.id).count).to eq(2)
    end

    it 'should return available projects without public' do
      expect(Project.available(@org.id, false).count).to eq(1)
    end

    context 'when managing a project' do
      let(:org) { FactoryGirl.create(:organisation) }
      let(:project) { FactoryGirl.create(:project, organisation: org) }

      it 'should allow admin to manage' do
        admin = FactoryGirl.create(:user, role: :admin)
        expect(project.manager?(admin)).to be_true
      end

      it 'should allow this orgs owner to manage' do
        owner = FactoryGirl.create(:user, role: :owner, organisation: org)
        expect(project.manager?(owner)).to be_true
      end

      it 'should not allow another orgs owner to manage' do
        owner = FactoryGirl.create(:user, role: :owner)
        expect(project.manager?(owner)).to be_false
      end

      it 'should not allow a regular user to manage' do
        user = FactoryGirl.create(:user, organisation: org)
        expect(project.manager?(user)).to be_false
      end

    end
  end
end
