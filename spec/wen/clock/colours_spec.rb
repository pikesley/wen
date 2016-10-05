module Wen
  describe Clock do
    it 'sets colours' do
      c = Config.instance.config.neopixels['hours']['colours']['hands']
      described_class.colours ({
        'hours' => {
          'hands' => [
            0, 255, 0
          ]
        }
      })
      expect(Config.instance.config.neopixels['hours']['colours']['hands']).to eq [
        0, 255, 0
      ]

      Config.instance.config.neopixels['hours']['colours']['hands'] = c
    end

    specify 'colours remain' do
      mf = Config.instance.config.neopixels['minutes']['colours']['hands']
      mg = Config.instance.config.neopixels['minutes']['colours']['face']
      hf = Config.instance.config.neopixels['hours']['colours']['hands']
      hg = Config.instance.config.neopixels['hours']['colours']['face']

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

      Config.instance.config.neopixels['minutes']['colours']['hands'] = mf
      Config.instance.config.neopixels['minutes']['colours']['face'] = mg
      Config.instance.config.neopixels['hours']['colours']['hands'] = hf
      Config.instance.config.neopixels['hours']['colours']['face'] = hg
    end
  end
end
