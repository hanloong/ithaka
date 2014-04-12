require 'spec_helper'

describe ApplicationController do

  include AuthHelper
  before(:each) do
    http_login
  end

  it 'should use http auth in production' do
    Rails.stub(env: ActiveSupport::StringInquirer.new('production'))
    controller.send :authenticate
    expect(response).to be_success
  end

  it 'should redirct to referrer if exits on login' do
    controller.stub(:stored_location_for).and_return('/test/path')
    expect(controller.after_sign_in_path_for(1)).to eq('/test/path')
  end

  it 'should redirct to projects path by default' do
    controller.stub(:stored_location_for).and_return(nil)
    expect(controller.after_sign_in_path_for(1)).to eq(projects_path)
  end
end
