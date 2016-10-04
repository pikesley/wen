module Neoclock
  class Neopixels
    include Singleton

    def initialize
      @config = Config.instance.config

      @total_size = 0
      @config.neopixels.each_pair do |ring, data|
        @total_size += data['pins']
      end

      @rings = PixelPi::Leds.new \
        @total_size,
        @config.led['pin'],
        frequency: @config.led['freq'],
        dma: @config.led['dma'],
        brightness: @config.led['brightness'],
        invert: @config.led['invert']
    end

    def rings
      @rings
    end

# should this take a list of 'red' etc and look up the colours?
    def set colours
      colours.each_with_index do |colour, i|
        rings[i] = PixelPi::Color *colour
      end
    end

    def illuminate colours
      set colours
      rings.show
    end

    def show
      rings.show
    end
  end
end
