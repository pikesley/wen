$is_pi = RUBY_PLATFORM =~ /linux/

if ENV['RACK_ENV'] == 'test'
  $is_pi = false
end

module Wen
  module Helpers
    def is_pjax?
      env['HTTP_X_PJAX']
    end

    def titlecase words
      words.split(' ').map { |w| "#{w[0].upcase}#{w[1..-1].downcase}" }.join ' '
    end

    def get_title key
      titlecase Wen::Config.instance.config.words['heading'][key]
    end
  end
end
