require 'spec_helper'

describe Organisation do
  it 'can store organisations' do
    expect do
      create(:organisation)
    end.to change { Organisation.count }.by(1)
  end
end
