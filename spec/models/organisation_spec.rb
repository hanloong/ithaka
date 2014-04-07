require 'spec_helper'

describe Organisation do
  it "can store organisations" do
    expect{
      FactoryGirl.create(:organisation)
    }.to change{ Organisation.count }.by(1)
  end
end
