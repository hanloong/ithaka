require 'spec_helper'

describe SubscriptionService do
  it 'has the plans' do
    s = SubscriptionService.new
    expect(s.plans).to eq({small: 50, medium: 200})
  end
end
