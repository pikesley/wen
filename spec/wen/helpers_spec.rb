class TestHelper
  include Wen::Helpers
end

module Wen
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'says hello' do
      expect(helpers.hello).to eq 'Hello'
    end

    it 'has a config' do
      expect(Wen::Config.instance.config).to be_a OpenStruct
    end
  end
end
