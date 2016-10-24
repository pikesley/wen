unless ENV['RACK_ENV'] == 'test'
  IS_PI = RUBY_PLATFORM =~ /linux/
end

module Wen
  module Helpers
  end
end
