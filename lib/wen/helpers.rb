$is_pi = RUBY_PLATFORM =~ /linux/

if ENV['RACK_ENV'] == 'test'
  $is_pi = false
end

module Wen
  module Helpers
  end
end
