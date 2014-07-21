require 'rails_helper'

describe SubscriptionsController, type: :controller do
  before :each do
    org = create(:organisation)
    @user = create(:user, organisation: org)
    sign_in @user
  end
  describe 'POST "create"' do
    it 'should submit to the payment service' do
      post :create, organisation_id: @user.organisation_id
      expect(response.status).to eq(302)
    end
  end
end
