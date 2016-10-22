module Wen
  class ClockWorker
    include Sidekiq::Worker

    def perform action, params = {params: 'none'}
      puts "#{action}: #{params}" unless (IS_PI || ENV['RACK_ENV'] == 'test')

      case action
      when 'time'
        Clock.time

      when 'mode'
        Clock.mode = params['mode']

      when 'tricks'
        Clock::Tricks.send(params['trick'].to_sym)

      when 'colours'
        Clock.send(:colours, params)
        Clock.time

      when 'reset'
        case params['reset']
        when 'colours'
          Wen.stash_colours
        end
        Clock.time
      end
    end
  end
end
