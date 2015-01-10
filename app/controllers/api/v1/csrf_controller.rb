class Api::V1::CsrfController < Api::AbstractController
  skip_before_action :verify_current_user!

  def index
    render json: { request_forgery_protection_token => form_authenticity_token }.to_json
  end
end
