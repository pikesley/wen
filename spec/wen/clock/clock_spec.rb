module Wen
  describe Clock do
    context 'show the time' do
      before :each do
        Clock.mode = 'vague'
      end

      it 'shows an on-the-hour time' do
        Timecop.freeze DateTime.parse '13:00' do
          expect(Neopixels.instance).to receive(:illuminate).with [
            $hand_colour, $hand_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $hand_colour,

            $face_colour, $hand_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour
          ]
          described_class.time
        end
      end

      it 'shows a half-past-the-hour time' do
        Timecop.freeze DateTime.parse '09:30' do
          expect(Neopixels.instance).to receive(:illuminate).with [
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $hand_colour,
            $hand_colour, $hand_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,

            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $face_colour, $face_colour, $face_colour,
            $hand_colour, $face_colour, $face_colour
          ]
          described_class.time
        end
      end

      context 'edge cases' do
        it 'handles on-the-hour' do
          Timecop.freeze DateTime.parse '09:00' do
            expect(Neopixels.instance).to receive(:illuminate).with [
              $hand_colour, $hand_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $hand_colour,

              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $hand_colour, $face_colour, $face_colour
            ]
            described_class.time
          end
        end

        it 'handles one-minute-to' do
          Timecop.freeze DateTime.parse '20:59' do
            expect(Neopixels.instance).to receive(:illuminate).with [
              $hand_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $hand_colour, $hand_colour,

              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $face_colour,
              $face_colour, $face_colour, $hand_colour,
              $face_colour, $face_colour, $face_colour
            ]
            described_class.time
          end
        end
      end
    end
  end
end
