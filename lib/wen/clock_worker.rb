module Wen
  class ClockWorker
    include Sidekiq::Worker

    def perform action, params
      case action
      when 'display'
        Clock::Tricks.send(params['mode'].to_sym)
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
