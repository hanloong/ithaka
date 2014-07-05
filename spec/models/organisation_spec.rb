require 'spec_helper'

describe Organisation do
  it 'can store organisations' do
    expect do
      create(:organisation)
    end.to change { Organisation.count }.by(1)
  end

  it 'requires a name' do
    expect(Organisation.new(name: '')).not_to be_valid
  end
end
