module Wen
  describe Clock do
    it 'sets colours' do
      c = Config.instance.config.neopixels['hours']['colours']['figure']
      described_class.colours ({
        'hours' => {
          'figure' => [
            0, 255, 0
          ]
        }
      })
      expect(Config.instance.config.neopixels['hours']['colours']['figure']).to eq [
        0, 255, 0
      ]

      Config.instance.config.neopixels['hours']['colours']['figure'] = c
    end

    specify 'colours remain' do
      mf = Config.instance.config.neopixels['minutes']['colours']['figure']
      mg = Config.instance.config.neopixels['minutes']['colours']['ground']
      hf = Config.instance.config.neopixels['hours']['colours']['figure']
      hg = Config.instance.config.neopixels['hours']['colours']['ground']

      described_class.colours ({
        'minutes' => {
          'figure' => [
            250, 129, 0
          ],
          'ground' => [
            0, 121, 250
          ]
        },
        'hours' => {
          'figure' => [
            255, 0, 255
          ],
          'ground' => [
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

      Config.instance.config.neopixels['minutes']['colours']['figure'] = mf
      Config.instance.config.neopixels['minutes']['colours']['ground'] = mg
      Config.instance.config.neopixels['hours']['colours']['figure'] = hf
      Config.instance.config.neopixels['hours']['colours']['ground'] = hg
    end
  end
end
