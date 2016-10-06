require 'timecop'

module Wen
  module Clock
    module Tricks
      def self.one_colour colour
        Neopixels.instance.illuminate(
          Array.new(
            Config.instance.config.neopixels['minutes']['pins'] +
            Config.instance.config.neopixels['hours']['pins'],
            colour
          )
        )
      end

      def self.blink duration = 1
        self.one_colour Clock.fetch_colour 'minutes', 'face'
        sleep duration unless ENV['environment'] == 'test'
        Clock.time
      end

      def self.roll_around
        now = Clock.time.strftime('%s').to_i
        tomorrow = now + 86400
        while now <= tomorrow
          Timecop.freeze DateTime.strptime(now.to_s, '%s') do
            Clock.time
            now += 3930
            sleep 0.05 unless ENV['environment'] == 'test'
          end
        end

        Clock.time
      end

      def self.clear
        c = Array.new(
          Config.instance.config.neopixels['minutes']['pins'] +
          Config.instance.config.neopixels['hours']['pins'],
          [0,0,0]
        )
        Neopixels.instance.illuminate c
      end

      def self.shuffle iterations = 64
        iterations.times do
          Clock.time DateTime.strptime(Random.rand(86400).to_s, '%s')
          sleep 0.05 unless ENV['environment'] == 'test'
        end

        Clock.time
      end

      def self.boot_up
        self.clear
        sleep 1 unless ENV['environment'] == 'test'

        a = []
        Config.instance.config.neopixels['minutes']['pins'].times do |i|
          a.push Config.instance.config['colours']['red']
          Neopixels.instance.illuminate a
          sleep 0.5 unless ENV['environment'] == 'test'
        end

        Config.instance.config.neopixels['hours']['pins'].times do |i|
          a.push Config.instance.config['colours']['blue']
        end
        Neopixels.instance.illuminate a
        sleep 2 unless ENV['environment'] == 'test'

        Clock.time
      end
    end
  end
end
