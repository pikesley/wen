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

      def self.align_clock
        self.clear
        a = []
        a[0] = Config.instance.config['colours']['red']
        [
          Config.instance.config.neopixels['minutes']['pins'] / 2,
          Config.instance.config.neopixels['minutes']['pins'],
          Config.instance.config.neopixels['minutes']['pins'] + (Config.instance.config.neopixels['hours']['pins'] / 2)
        ].each do |i|
          a[i] = Config.instance.config['colours']['green']
        end

        Wen::Neopixels.instance.illuminate array_filler(a)
        self.kip 10

        Clock.time
      end

      def self.blink duration = 1
        self.clear
        self.kip duration / 10.0
        self.one_colour Clock.fetch_colour 'minutes', 'hand'
        self.kip duration
        self.clear
        self.kip duration / 10.0

        Clock.time
      end

      def self.roll_around
        current_mode = Clock.mode
        Clock.mode = 'range'
        now = Clock.time.strftime('%s').to_i
        tomorrow = now + 86400
        while now <= tomorrow
          Timecop.freeze DateTime.strptime(now.to_s, '%s') do
            Clock.time
            now += 3930
            self.kip 0.05
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

          self.kip 0.2
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
          self.kip 0.1
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
            self.kip 0.2
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
        Clock.mode = 'range'
        iterations.times do
          Clock.time DateTime.strptime(Random.rand(86400).to_s, '%s')
          self.kip 0.05

        end

        Clock.mode = current_mode
        Clock.time
      end

      def self.boot_up
        self.clear
        self.kip 1

        a = []
        Config.instance.config.neopixels['minutes']['pins'].times do |i|
          a.push Config.instance.config['colours']['red']
          Neopixels.instance.illuminate a
          self.kip 0.25

        end

        Config.instance.config.neopixels['hours']['pins'].times do |i|
          a.push Config.instance.config['colours']['blue']
        end
        Neopixels.instance.illuminate a
        self.kip 1

        Clock.time
      end

# from pixel_pi demo mode

      def self.wipe
        self.clear
        a = []
        Wen::Config.instance.config.colours.keys[3..-1].each do |key|
          TOTAL_LENGTH.times do |i|
            a[i] = Wen::Config.instance.config.colours[key]
            Wen::Neopixels.instance.illuminate a
            self.kip 25 / 1000.0
          end
        end

        self.kip 1
        Clock.time
      end

      def self.array_filler a
        a.map do |i|
          unless i
            i = [0, 0, 0]
          else
            i = i
          end
        end
      end

      # Reverse version?
      def self.super_wipe
        a = []
        (Wen::Config.instance.config.colours.keys[3..-1] + ['black']).each do |key|
          Wen::Config.instance.config.neopixels['minutes']['pins'].times do |i|
            a[i] = Wen::Config.instance.config.colours[key]
            if i % 2 == 1
              a[Wen::Config.instance.config.neopixels['minutes']['pins'] + i / 2] = Wen::Config.instance.config.colours[key]
            end
            Wen::Neopixels.instance.illuminate array_filler(a)
            self.kip 25 / 1000.0
          end
        end

        Clock.time
      end

      def self.theatre_chase spacing = 3
        a = []
        colour = Wen::Clock.fetch_colour 'minutes', 'hand'
        ITERATIONS.times do
          spacing.times do |sp|
            Wen::Clock::Tricks.clear
            (sp...TOTAL_LENGTH).step(spacing) do |ii|
              a[ii] = colour
            end
            Wen::Neopixels.instance.illuminate array_filler(a)
            self.kip 75 / 1000.0
          end
        end

        Clock.time
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
        ITERATIONS.times do |jj|
          spacing.times do |sp|
            a = []
            (sp..TOTAL_LENGTH).step(spacing) do |ii|
              a[ii] = Wen::Clock::Tricks.wheel((ii + jj) % 255)
            end
            Wen::Neopixels.instance.illuminate array_filler(a)

            self.kip 75 / 1000.0
          end
        end

        Clock.time
      end

      def self.kip time
        sleep time if $is_pi
      end
    end
  end
end
