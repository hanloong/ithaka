class SubscriptionsController < ApplicationController
  before_action :set_organisation

  def new
  end

  def create
    subscriber = SubscriptionService.new subscription_params.merge(email: current_user.email)
    subscriber.subscribe
    redirect_to organisation_subscriptions_path(@organisation), notice: 'Subscribed'
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_organisation
    @organisation = current_user.organisation
  end

  def subscription_params
    params.permit(:token, :plan)
  end

end
