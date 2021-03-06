require 'spec_helper'

describe Project do
  before :each do
    @org = create(:organisation)
    @attr = {
      name: 'Make money',
      description: 'For reals',
      organisation: @org
    }
  end

  it 'should never be anonymous' do
    p = Project.new(@attr)
    expect(p.anonymous?).to be_falsy
  end

  it 'should show name for to_s' do
    p = Project.new(@attr)
    expect(p.to_s).to eq(@attr[:name])
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
        org2 = create(:organisation)
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
      expect(Project.available(@org).count).to eq(2)
    end

    it 'should return available projects without public' do
      expect(Project.available(@org, false).count).to eq(1)
    end

    context 'when managing a project' do
      let(:org) { create(:organisation) }
      let(:project) { create(:project, organisation: org) }

      it 'should allow admin to manage' do
        admin = create(:user, role: :admin)
        expect(project.manager?(admin)).to be_truthy
      end

      it 'should allow this orgs owner to manage' do
        owner = create(:user, role: :owner, organisation: org)
        expect(project.manager?(owner)).to be_truthy
      end

      it 'should not allow another orgs owner to manage' do
        owner = create(:user, role: :owner)
        expect(project.manager?(owner)).to be_falsy
      end

      it 'should not allow a regular user to manage' do
        user = create(:user, role: :user, organisation: org)
        expect(project.manager?(user)).to be_falsy
      end

      describe '#has_access?' do
        let(:project) { create(:project, organisation: org) }

        it 'should allow access to user in same org' do
          user = create(:user, organisation: org)
          expect(project.has_access?(user)).to be_truthy
        end

        it 'should not allow access to user in other org' do
          org2 = create(:organisation)
          user = create(:user, organisation: org2)
          expect(project.has_access?(user)).to be_falsy
        end

        it 'should allow access to public projects' do
          project.update(public: true)
          org2 = create(:organisation)
          user = create(:user, organisation: org2)
          expect(project.has_access?(user)).to be_truthy
        end
      end

      describe '#is_public?' do
        it 'should allow access to public projects' do
          project.update(public: true)
          org2 = create(:organisation)
          user = create(:user, organisation: org2)
          expect(project.is_public?(user)).to be_truthy
        end

        it 'should not say project in own org is public' do
          project.update(public: true)
          user = create(:user, organisation: project.organisation)
          expect(project.is_public?(user)).to be_falsy
        end
      end
    end
  end
end
