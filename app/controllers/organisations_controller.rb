class OrganisationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organisation

  def edit
  end

  def update
    if @organisation.update organisation_params
      redirect_to edit_organisation_path, notice: 'Organisation updated..'
    else
      redirect_to edit_organisation_path, alert: 'Ooops, something went wrong'
    end
  end

  private

  def set_organisation
    @organisation = current_user.organisation
  end

  def organisation_params
    params.require(:organisation).permit(:name)
  end
end
