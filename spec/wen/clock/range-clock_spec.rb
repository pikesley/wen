module Wen
  describe Clock do
    context 'show the time as a range' do
      before :each do
        Clock.mode= 'range'
      end

      it 'shows an on-the-hour time' do
        Config.instance.config.clock_type = :range
        Timecop.freeze DateTime.parse '13:00' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(1, [255, 0, 0]) +
            Array.new(23, [0, 0, 255]) +

            [
              [0, 0, 255], [255, 0, 0], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [0, 0, 255]
            ]
          )
          described_class.time
        end
      end

      it 'shows a half-past-the-hour time' do
        Timecop.freeze DateTime.parse '09:30' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(13, [255, 0, 0]) +
            Array.new(11, [0, 0, 255]) +

            [
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [255, 0, 0], [0, 0, 255], [0, 0, 255]
            ]
          )
          described_class.time
        end
      end

      it 'shows a quarter-past time' do
        Timecop.freeze DateTime.parse '09:15' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(7, [255, 0, 0]) +
            Array.new(17, [0, 0, 255]) +

            [
             [0, 0, 255], [0, 0, 255], [0, 0, 255],
             [0, 0, 255], [0, 0, 255], [0, 0, 255],
             [0, 0, 255], [0, 0, 255], [0, 0, 255],
             [255, 0, 0], [0, 0, 255], [0, 0, 255]
           ]
          )
          described_class.time
        end
      end

      it 'shows a quarter-to time' do
        Timecop.freeze DateTime.parse '20:45' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(19, [255, 0, 0]) +
            Array.new(5, [0, 0, 255]) +

            [
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [0, 0, 255],
              [0, 0, 255], [0, 0, 255], [255, 0, 0],
              [0, 0, 255], [0, 0, 255], [0, 0, 255]
            ]
          )
          described_class.time
        end
      end
    end
  end
end
