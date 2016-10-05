require 'timecop'

module Wen
  class Clock
    def self.shuffle iterations = 64
      iterations.times do
        self.time DateTime.strptime(Random.rand(86400).to_s, '%s')
        sleep 0.05 unless ENV['environment'] == 'test'
      end

      self.time
    end

    def self.swing
      t = 82800 + 1800
      while t <= 864000
        Timecop.freeze DateTime.strptime(t.to_s, '%s') do
          self.time
          t += 3930
        end
        sleep 0.05
      end
      self.time
    end

    def self.boot_up
      c = Array.new(
        Config.instance.config.neopixels['minutes']['pins'] +
        Config.instance.config.neopixels['hours']['pins'],
        [0,0,0]
      )
      Neopixels.instance.illuminate c
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

      self.time
    end
  end
end
