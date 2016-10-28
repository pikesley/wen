module Wen
  describe App do
    context 'set colours' do
      it 'sets the time' do
        post '/colours', { hours: {hand: [0, 255, 0] } }.to_json, JSON_HEADERS
        expect(ColourWorker).to have_enqueued_job(
          {
            'hours' => {
              'hand' => [
                0, 255, 0
              ]
            }
          }
        )
        expect(Clock).to receive(:colours).with ({
          'hours' => {
            'hand' => [
              0, 255, 0
            ]
          }
        })
        ColourWorker.drain
      end
    end

    context 'get colours' do
      it 'returns a colour' do
        get '/colours/hours/hand', nil, JSON_HEADERS
        expect(last_response).to be_ok
        expect(JSON.parse last_response.body).to eq (
          {
            'colour' => [
              255, 0, 0
            ]
          }
        )
      end

      it 'returns all the colours' do
        get '/colours/', nil, JSON_HEADERS
        expect(last_response).to be_ok
        expect(JSON.parse last_response.body).to eq (
          {
            "black" => [0, 0, 0],
            "grey" => [127, 127, 127],
            "white" => [255, 255, 255],
            "red" => [255, 0, 0],
            "red-magenta" => [255, 0, 127],
            "magenta" => [255, 0, 255],
            "magenta-blue" => [127, 0, 255],
            "blue" => [0, 0, 255],
            "blue-cyan" => [0, 127, 255],
            "cyan" => [0, 255, 255],
            "cyan-green" => [0, 255, 127],
            "green" => [0, 255, 0],
            "green-yellow" => [127, 255, 127],
            "yellow" => [255, 255, 0],
            "yellow-red" => [255, 127, 0]
          }
        )
      end
    end
  end
end
