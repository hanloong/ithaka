class InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # monkey patch to assign user to org
  def invite_resource(&block)
    new_params = invite_params
    unless new_params.include?(:organisation)
      new_params[:organisation_id] = current_user.organisation_id
    end
    resource_class.invite!(new_params, current_inviter, &block)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:invite) do |u|
      u.permit(:name, :email, :role, :organisation_id)
    end
  end
end
