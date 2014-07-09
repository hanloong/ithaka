class SubscriptionService
  include ActiveModel::Model

  attr_accessor :token, :plan, :email

  def subscribe
    customer = Stripe::Customer.create(
      card: token,
      plan: plan,
      email: email
    )
  end

  def update
  end

  def destroy
  end

  def plans
    {small: 50, medium: 200}
  end

end
