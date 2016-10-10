module Wen
  describe Clock do
    before :each do
      Clock.mode= 'vague'
    end
    
    it 'sets colours' do
      described_class.colours ({
        'hours' => {
          'hands' => [
            0, 255, 0
          ]
        }
      })

      expect($redis.get 'hours/hands').to eq '0, 255, 0'
    end

    specify 'colours remain' do
      described_class.colours ({
        'minutes' => {
          'hands' => [
            250, 129, 0
          ],
          'face' => [
            0, 121, 250
          ]
        },
        'hours' => {
          'hands' => [
            255, 0, 255
          ],
          'face' => [
            0, 255, 0
          ]
        }
      })

      Timecop.freeze DateTime.parse '13:00' do
        expect(Neopixels.instance).to receive(:illuminate).with [
          [250, 129, 0], [250, 129, 0], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [0, 121, 250],
          [0, 121, 250], [0, 121, 250], [250, 129, 0],

          [0, 255, 0], [255, 0, 255], [0, 255, 0],
          [0, 255, 0], [0, 255, 0], [0, 255, 0],
          [0, 255, 0], [0, 255, 0], [0, 255, 0],
          [0, 255, 0], [0, 255, 0], [0, 255, 0]
        ]
        described_class.time
      end
    end
  end
end
