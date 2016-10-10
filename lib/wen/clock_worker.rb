module Wen
  class ClockWorker
    include Sidekiq::Worker

    def perform action, params # = {params: 'none'}
      puts "#{action}: #{params}" unless (IS_PI || ENV['environment'] == 'test')
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
        Wen.stash_defaults
        Clock.time
      end
    end
  end
end
