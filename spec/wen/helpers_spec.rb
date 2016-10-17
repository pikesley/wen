class TestHelper
  include Wen::Helpers
end

module Wen
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'fails deliberately' do
      expect(false).to be true
    end
  end
end
