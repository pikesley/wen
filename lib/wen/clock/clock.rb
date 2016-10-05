module Wen
  class Clock
    def self.time dt = DateTime.now
      Neopixels.instance.illuminate (Clock.wheel 'minutes', dt) + (Clock.wheel 'hours', dt)
    end

    def self.wheel type, time
      config = Config.instance.config
      l = []
      hands = config.neopixels[type]['colours']['hands']
      face = config.neopixels[type]['colours']['face']
      config.neopixels[type]['pins'].times do
        l.push face
      end
      Clock.send(:"#{type}_pins", time).map { |i| l[i] = hands }

      l
    end

    def self.hours_pins time
      [time.hour % 12]
    end

    def self.minutes_pins time
      total_pins = Config.instance.config.neopixels['minutes']['pins']
      Clock.bracketise ((total_pins / 60.0) * time.minute).to_i, total_pins
    end

    def self.bracketise pin, length
      a = []
      first = pin - 1
      if first < 0
        first = length - 1
      end
      a.push first

      a.push pin

      last = (pin + 1) % length
      a.push last
      a.sort!
    end

    def self.colours params
      params.each_pair do |hand, values|
        values.each_pair do |layer, colour|
          Config.instance.config.neopixels[hand]['colours'][layer] = colour
        end
      end
    end
  end
end
