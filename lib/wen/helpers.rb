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

    def next_and_previous request_path
      pages = Wen::Config.instance.config['pages'].map { |page| page['name'] }

      index = pages.index request_path

      np = {
        next: nil,
        previous: nil
      }

      np[:next] = pages[index + 1]
      np[:previous] = pages[index - 1] unless index == 0

      np
    end

    def self.with_logging params = nil
      puts "Starting #{self.name}: #{params}" unless ENV['RACK_ENV'] == 'test'
      yield
      puts "Finishing #{self.name}: #{params}" unless ENV['RACK_ENV'] == 'test'
    end
  end
end
