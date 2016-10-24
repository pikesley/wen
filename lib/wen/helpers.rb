IS_PI = RUBY_PLATFORM =~ /linux/

if ENV['RACK_ENV'] == 'test'
  IS_PI = false
end

module Wen

  module Helpers
  end
end
