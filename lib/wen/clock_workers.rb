module Wen
  class ClockWorker
    include Sidekiq::Worker
    include Helpers
  end

  class ColourWorker < ClockWorker
    sidekiq_options queue: 'colours'

    def perform params
      Helpers.with_logging(params) do
        case params
        when 'reset'
          Wen.stash_colours
        when 'scramble'
          Clock.scrambled_colours
        else
          Clock.colours params
        end

        Clock.time
      end
    end
  end

  class ModeWorker < ClockWorker
    sidekiq_options queue: 'modes'

    def perform params
      Helpers.with_logging(params) do
        Clock.mode = params['mode']
      end
    end
  end

  class TrickWorker < ClockWorker
    sidekiq_options queue: 'tricks'

    def perform params
      Helpers.with_logging(params) do
        Clock::Tricks.send(params['trick'].to_sym)
      end
    end
  end

  class TimeWorker < ClockWorker
    sidekiq_options queue: 'time'

    def perform
      Helpers.with_logging do
        Clock.time
      end
    end
  end
end
