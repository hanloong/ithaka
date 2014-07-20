require 'spec_helper'

describe Comment do
  let(:user) { mock_model(User, email: 'test@email.com') }
  let(:idea) { mock_model(Idea, name: 'test', description: 'test', user_id: 1, allow_anonymous: false) }

  before :each do
    @attrs = { user: user, idea: idea, comment: 'some text' }
  end

  it 'should save a valid comment' do
    expect(Comment.new(@attrs)).to be_valid
  end

  it 'should be invalid without comment' do
    @attrs[:comment] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end

  it 'should be invalid without idea' do
    @attrs[:idea] = nil
    expect(Comment.new(@attrs)).not_to be_valid
  end

  context 'when idea doesn\'t allow anonymous' do
    it 'should not allow anonymous user' do
      @attrs[:user] = nil
      expect(Comment.new(@attrs)).not_to be_valid
    end
  end

  context 'when idea allows anonymous' do
    let(:idea) { mock_model(Idea, name: 'test', description: 'test', user_id: 1, allow_anonymous: true) }
    it 'should not allow anonymous user' do
      @attrs[:user] = nil
      expect(Comment.new(@attrs)).to be_valid
    end
  end
end
