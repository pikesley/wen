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
              *$hand_colour
            ]
          }
        )
      end

      it 'returns all the colours' do
        get '/colours/', nil, JSON_HEADERS
        expect(last_response).to be_ok
        expect(JSON.parse last_response.body).to include (
          {
            "black" => [0, 0, 0],
            "white" => [255, 255, 255],
            "red" => [255, 0, 0],
            "magenta" => [255, 0, 255],
            "blue" => [0, 0, 255],
            "cyan" => [0, 255, 255],
            "green" => [0, 255, 0],
            "yellow" => [255, 255, 0],
          }
        )
      end
    end

    context 'reset colours' do
      it 'sets colours if none exist' do
        $redis.flushall
        Wen.stash_colours
        expect(Clock.fetch_colour 'hours', 'hand').to eq $hand_colour
      end

      it 'does not overwrite an existing colour' do
        post '/colours', { hours: {hand: [0, 255, 0] } }.to_json, JSON_HEADERS
        Wen.stash_colours
        ColourWorker.drain
        expect(Clock.fetch_colour 'hours', 'hand').to eq [0, 255, 0]
      end

      it 'unless we insist' do
        post '/colours', { hours: {hand: [0, 255, 0] } }.to_json, JSON_HEADERS
        post '/colours/reset', nil, JSON_HEADERS
        ColourWorker.drain
        expect(Clock.fetch_colour 'hours', 'hand').to eq $hand_colour
      end
    end
  end
end
