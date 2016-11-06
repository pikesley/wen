class TestHelper
  include Wen::Helpers
end

module Wen
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'gets a page title' do
      expect(helpers.get_title 'modes').to eq 'Clock Modes'
    end

    it 'titlecases a string' do
      expect(helpers.titlecase 'clock modes').to eq 'Clock Modes'
    end
  end
end
