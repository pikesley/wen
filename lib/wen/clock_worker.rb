module Wen
  class ClockWorker
    include Sidekiq::Worker

    def perform action, params
      puts "#{action}: #{params}" unless IS_PI
      case action
      when 'display'
        case params['mode']
        when 'time'
          Clock.time
        else
          Clock::Tricks.send(params['mode'].to_sym)
        end
      when 'colours'
        Clock.send(:colours, params)
        Clock.time
      when 'reset'
        Wen.stash_colours
        Clock.time
      end
    end
  end
end
