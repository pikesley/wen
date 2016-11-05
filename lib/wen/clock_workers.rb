module Wen
  class ClockWorker
    include Sidekiq::Worker

    def self.commence params = 'none'
      puts "Starting #{self.name}: #{params}" unless ENV['RACK_ENV'] == 'test'
    end

    def self.cease params = 'none'
      puts "Finishing #{self.name}: #{params}" unless ENV['RACK_ENV'] == 'test'
    end
  end

  class ColourWorker < ClockWorker
    sidekiq_options queue: 'colours'

    def perform params
      self.class.commence params
      case params
      when 'reset'
        Wen.stash_colours
      when 'scramble'
        keys = Wen::Config.instance.config.colours.keys.shuffle
        d = {}

        d['hours'] = {}
        d['hours']['hand'] = Wen::Config.instance.config.colours[keys.shift]
        d['hours']['face'] = Wen::Config.instance.config.colours[keys.shift]

        d['minutes'] = {}
        d['minutes']['hand'] = Wen::Config.instance.config.colours[keys.shift]
        d['minutes']['face'] = Wen::Config.instance.config.colours[keys.shift]

        Clock.colours d
      else
        Clock.colours params
      end

      Clock.time
      self.class.cease params
    end
  end

  class ModeWorker < ClockWorker
    sidekiq_options queue: 'modes'

    def perform params
      self.class.commence params
      Clock.mode = params['mode']
      self.class.cease params
    end
  end

  class TrickWorker < ClockWorker
    sidekiq_options queue: 'tricks'

    def perform params
      self.class.commence params
      Clock::Tricks.send(params['trick'].to_sym)
      self.class.cease params
    end
  end

  class TimeWorker < ClockWorker
    sidekiq_options queue: 'time'

    def perform
      self.class.commence
      Clock.time
      self.class.cease
    end
  end
end
