require 'spec_helper'

describe Project do
  before :each do
    @attr = {
      name: 'Make money',
      description: 'For reals'
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
end
