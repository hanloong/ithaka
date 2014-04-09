require 'spec_helper'

describe ApplicationHelper do
  describe '#markdown' do
    it 'should convert mardown to html' do
      expect(helper.markdown('# title')).to eq("<h1>title</h1>\n")
    end
  end
end
