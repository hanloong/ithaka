require 'spec_helper'

describe Favourite do
  before :each do
    @user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, organisation: @user.organisation)
    @idea = FactoryGirl.create(:idea, project: project, user: @user)
    @attr = {
      idea: @idea,
      user: @user
    }
  end

  it 'should return exiting favourite for user' do
    fav = Favourite.create(@attr)
    expect(Favourite.existing_favourite(@user.id)).to eq([fav])
  end
end
