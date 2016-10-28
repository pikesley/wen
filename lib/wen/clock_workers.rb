module Wen
  class ClockWorker
    include Sidekiq::Worker

    def self.report params = 'none'
      puts "#{self.name}: #{params}" unless ($is_pi || ENV['RACK_ENV'] == 'test')
    end
  end

  class ColourWorker < ClockWorker
    sidekiq_options queue: 'colours'

    def perform params
      self.class.report params

      if params == 'reset'
        Wen.stash_colours
      else
        Clock.send(:colours, params)
      end
    end
  end

  class ModeWorker < ClockWorker
    sidekiq_options queue: 'modes'

    def perform params
      self.class.report params

      Clock.mode = params['mode']
    end
  end

  class TrickWorker < ClockWorker
    sidekiq_options queue: 'tricks'

    def perform params
      self.class.report params

      Clock::Tricks.send(params['trick'].to_sym)
    end
  end

  class TimeWorker < ClockWorker
    sidekiq_options queue: 'time'

    def perform
      self.class.report

      Clock.time
    end
  end
end
