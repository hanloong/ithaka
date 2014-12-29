class Api::V1::CsrfController < ApiController
  skip_before_action :authenticate_user!

  def index
    render json: { request_forgery_protection_token => form_authenticity_token }.to_json
  end
end
