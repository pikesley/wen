$is_pi = RUBY_PLATFORM =~ /linux/

if ENV['RACK_ENV'] == 'test'
  $is_pi = false
end

module Wen
  module Helpers
    def is_pjax?
      env['HTTP_X_PJAX']
    end
  end
end
