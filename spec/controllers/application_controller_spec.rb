require 'rails_helper'

describe ApplicationController, :type => :controller do

  include AuthHelper

  context 'when logged in' do
    before do
      http_login
    end

    it 'should redirct to referrer if exits on login' do
      allow(controller).to receive(:stored_location_for).and_return('/test/path')
      expect(controller.after_sign_in_path_for(1)).to eq('/test/path')
    end

    it 'should redirct to projects path by default' do
      allow(controller).to receive(:stored_location_for).and_return(nil)
      expect(controller.after_sign_in_path_for(1)).to eq(projects_path)
    end

  end
end
