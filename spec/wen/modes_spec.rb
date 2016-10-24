module Wen
  describe App do
    context 'set the mode' do
      it 'sets the mode' do
        post '/modes', { mode: 'vague' }.to_json, JSON_HEADERS
        expect(ClockWorker).to have_enqueued_job 'mode', {
          mode: 'vague'
        }
        expect(Clock).to receive(:mode=).with 'vague'
        ClockWorker.drain
      end

      it 'gets the mode' do
        Clock.mode = 'strict'
        get '/modes', nil, JSON_HEADERS
        expect(JSON.parse last_response.body).to eq (
          {
            'mode' => 'strict'
          }
        )
      end
    end
  end
end
