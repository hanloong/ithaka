require 'spec_helper'

describe Comment do
  let(:user) { mock_model(User, email: 'test@email.com') }
  let(:idea) do
    mock_model(Idea,
               name: 'test',
               description: 'test',
               user_id: 1)
  end

  before :each do
    @attrs = {
      user: user,
      idea: idea,
      comment: 'some text'
    }
  end

  it 'should save a valid comment' do
    expect(Comment.new(@attrs)).to be_valid
  end

  it 'should be invalid without comment' do
    @attrs[:comment] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end

  it 'should be invalid without user' do
    @attrs[:user] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end

  it 'should be invalid without idea' do
    @attrs[:idea] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end
end
