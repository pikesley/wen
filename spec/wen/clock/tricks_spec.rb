module Wen
  describe Clock do
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

    context 'tricks' do
      it 'shuffles' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(65).times
        described_class.shuffle
      end

      it 'does a startup move' do
        expect(Neopixels.instance).to receive(:illuminate).exactly(27).times
        described_class.boot_up
      end

      # night mode?
      # ease into the actual time out of the trick modes?
      # blink mode
      # accelerate at startup
    end
  end
end
