require 'spec_helper'

module Ideas
  describe StatusPresenter do

    before do
      stub_const("Idea::STATUS", ['one', 'archived'])
      @sp = Ideas::StatusPresenter.new
    end

    it 'should return a collection of statuses' do
      expect(@sp.collection).to eq([['One', 'one'], ['Archived','archived']])
    end

    it 'should find_by_index' do
      expect(@sp.find_by_index(0)).to eq('One')
    end

    it 'should format nicley' do
      expect(@sp.titalise('a_status')).to eq("A Status")
    end

    it 'should not show archive in search group' do
      expect(@sp.search_group).to eq(['one'])
    end

    it 'should find selected statuses' do
      expect(@sp.group_status([[0, 10]])).to eq({'One' => 10})
    end
  end
end
