module Wen
  module Clock
    def self.time dt = DateTime.now
      Neopixels.instance.illuminate (Clock.wheel 'minutes', dt) + (Clock.wheel 'hours', dt)
      dt
    end

    def self.wheel type, time
      config = Config.instance.config
      l = []

      hands = fetch_colour type, 'hands'
      face = fetch_colour type, 'face'

      config.neopixels[type]['pins'].times do
        l.push face
      end
      Clock.send(:"#{type}_pins", time).map { |i| l[i] = hands }

      l
    end

    def self.fetch_colour type, layer
      $redis.get("#{type}/#{layer}").split(',').map { |n| n.to_i }
    end

    def self.hours_pins time
      [time.hour % 12]
    end

    def self.minutes_pins time
      total_pins = Config.instance.config.neopixels['minutes']['pins']
      case $redis.get 'clock_mode'
      when 'range'
        (0..(total_pins / 60.0) * time.minute).map { |i| i }
      when 'vague'
        Clock.bracketise ((total_pins / 60.0) * time.minute).to_i, total_pins
      end
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
      params.each_pair do |wheel, values|
        values.each_pair do |layer, colour|
          $redis.set "#{wheel}/#{layer}", colour.join(', ')
        end
      end
    end

    def self.mode= mode
      $redis.set 'clock_mode', mode
    end
  end
end
