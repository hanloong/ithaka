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
        Project.create(name: 'Public', description: 'Project', public: true, organisation_id: org2.id)
        Project.create(name: 'Private', description: 'Project', public: false, organisation_id: org2.id)
      end
    end

    it 'should return available projects' do
      expect(Project.available(@org.id).count).to eq(2)
    end

    it 'should return available projects without public' do
      expect(Project.available(@org.id, false).count).to eq(1)
    end
  end
end
