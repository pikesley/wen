class TestHelper
  include Wen::Helpers
end

module Wen
  describe Helpers do
    let(:helpers) { TestHelper.new }
  end
end
