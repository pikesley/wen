module Wen
  describe Clock do
    before :each do
      Clock.mode= 'vague'
    end
    
    it 'takes an arbitrary time' do
      Timecop.freeze DateTime.parse '19:00' do
        expect(Neopixels.instance).to receive(:illuminate).with [
          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [255, 0, 0],
          [255, 0, 0], [255, 0, 0], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255],

          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255],
          [255, 0, 0], [0, 0, 255], [0, 0, 255],
          [0, 0, 255], [0, 0, 255], [0, 0, 255]
        ]
        described_class.time DateTime.parse '06:30'
      end
    end
  end

  module Clock
    describe Tricks do
      it 'shuffles' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(65).times
        described_class.shuffle
      end

      it 'does a startup move' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(27).times
        described_class.boot_up
      end

      it 'clears everything' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(1).times
        described_class.clear
      end

      it 'sets a ring to a single colour' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(1).times.with (
          Array.new(36, [255, 0, 255])
        )
        described_class.one_colour [255, 0, 255]
      end

      it 'rolls around' do
        Timecop.freeze DateTime.parse '12:34' do
          expect(Neopixels.instance).to receive(:illuminate).at_least(12).times
          described_class.roll_around
        end
      end

      it 'blinks' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(4).times
        described_class.blink
      end

      # night mode?
      # ease into the actual time out of the trick modes?
      # accelerate at startup
    end
  end
end
