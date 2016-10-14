require 'timecop'

module Wen
  module Clock
    module Tricks
      TOTAL_LENGTH = Config.instance.config.neopixels['minutes']['pins'] +
                     Config.instance.config.neopixels['hours']['pins']
      ITERATIONS = 64

      def self.one_colour colour
        Neopixels.instance.illuminate(
          Array.new(TOTAL_LENGTH, colour)
        )
      end

      def self.blink duration = 1
        self.clear
        sleep duration / 10.0 if IS_PI
        self.one_colour Clock.fetch_colour 'minutes', 'hand'
        sleep duration if IS_PI
        self.clear
        sleep duration / 10.0 if IS_PI

        Clock.time
      end

      def self.roll_around
        current_mode = Clock.mode
        Clock.mode = 'vague'
        now = Clock.time.strftime('%s').to_i
        tomorrow = now + 86400
        while now <= tomorrow
          Timecop.freeze DateTime.strptime(now.to_s, '%s') do
            Clock.time
            now += 3930
            sleep 0.05 if IS_PI
          end
        end

        Clock.mode = current_mode
        Clock.time
      end

      def self.disco iterations = 64
        iterations.times do
          Neopixels.instance.illuminate Array.new(
            TOTAL_LENGTH,
            self.random_color
          )

          sleep 0.2
        end

        Clock.time
      end

      def self.chaos iterations = 64
        iterations.times do
          a = []
          (TOTAL_LENGTH).times do
            a.push self.random_color
          end
          Neopixels.instance.illuminate a
          sleep 0.1
        end

        Clock.time
      end

      def self.rotator iterations = 32
        white = Config.instance.config.colours['white']
        black = Config.instance.config.colours['black']
        length = (TOTAL_LENGTH) / 2
        iterations.times do
          [
            [white, black],
            [black, white]
          ].each do |pair|
            Neopixels.instance.illuminate pair * length
            sleep 0.2
          end
        end

        Clock.time
      end

      def self.random_color
        [
          Random.rand(255),
          Random.rand(255),
          Random.rand(255)
        ]
      end

      def self.clear
        c = Array.new(TOTAL_LENGTH, [0,0,0])
        Neopixels.instance.illuminate c
      end

      def self.shuffle iterations = 64
        current_mode = Clock.mode
        Clock.mode = 'vague'
        iterations.times do
          Clock.time DateTime.strptime(Random.rand(86400).to_s, '%s')
          sleep 0.05 if IS_PI

        end

        Clock.mode = current_mode
        Clock.time
      end

      def self.boot_up
        self.clear
        sleep 1 if IS_PI

        a = []
        Config.instance.config.neopixels['minutes']['pins'].times do |i|
          a.push Config.instance.config['colours']['red']
          Neopixels.instance.illuminate a
          sleep 0.25 if IS_PI

        end

        Config.instance.config.neopixels['hours']['pins'].times do |i|
          a.push Config.instance.config['colours']['blue']
        end
        Neopixels.instance.illuminate a
        sleep 1 if IS_PI

        Clock.time
      end

# from pixel_pi demo mode

      def self.wipe
        self.clear
        a = []
        Config.instance.config.colours.keys[3..-1].each do |key|
          TOTAL_LENGTH.times do |i|
            a[i] = Config.instance.config.colours[key]
            Neopixels.instance.illuminate a
            sleep 25 / 1000.0
          end
        end

        sleep 1
        Clock.time
      end

      def self.theatre_chase spacing = 3
        a = []
        colour = Clock.fetch_colour 'minutes', 'hand'
        ITERATIONS.times do
          spacing.times do |sp|
            self.clear
            (sp..TOTAL_LENGTH).step(spacing) do |ii|
              a[ii] = colour
            end
            Neopixels.instance.illuminate a
            sleep 75 / 1000.0
          end
        end
      end

      def self.wheel pos
        pos = pos & 0xff
        if pos < 85
          return [pos * 3, 255 - pos * 3, 0]
        elsif pos < 170
          pos -= 85
          return [255 - pos * 3, 0, pos * 3]
        else
          pos -= 170
          return [0, pos * 3, 255 - pos * 3]
        end
      end

      def self.rainbow_chase spacing = 3
        256.times do |jj|
          spacing.times do |sp|
            a = []
            (sp..TOTAL_LENGTH).step(spacing) do |ii|
              a[ii] = wheel((ii + jj) % 255)
            end
            Neopixels.instance.illuminate a

            sleep 75 / 1000.0
          end
        end
      end
    end
  end
end
