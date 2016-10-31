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
            Array.new(1, $hand_colour) +
            Array.new(23, $face_colour) +

            [
              $face_colour, $hand_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour
            ]
          )
          described_class.time
        end
      end

      it 'shows a half-past-the-hour time' do
        Timecop.freeze DateTime.parse '09:30' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(13, $hand_colour) +
            Array.new(11, $face_colour) +

            [
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $hand_colour, $face_colour, $face_colour
            ]
          )
          described_class.time
        end
      end

      it 'shows a quarter-past time' do
        Timecop.freeze DateTime.parse '09:15' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(7, $hand_colour) +
            Array.new(17, $face_colour) +

            [
             $face_colour, $face_colour, $face_colour,
             $face_colour, $face_colour, $face_colour,
             $face_colour, $face_colour, $face_colour,
             $hand_colour, $face_colour, $face_colour
           ]
          )
          described_class.time
        end
      end

      it 'shows a quarter-to time' do
        Timecop.freeze DateTime.parse '20:45' do
          expect(Neopixels.instance).to receive(:illuminate).with (
            Array.new(19, $hand_colour) +
            Array.new(5, $face_colour) +

            [
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $hand_colour,
              $face_colour, $face_colour, $face_colour
            ]
          )
          described_class.time
        end
      end
    end
  end
end
