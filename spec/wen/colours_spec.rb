module Wen
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    context 'set colours' do
      it 'sets the time' do
        patch '/colours', { hours: {hands: [0, 255, 0] } }.to_json, JSON_HEADERS
        expect(ClockWorker).to have_enqueued_job 'colours', {
          'hours' => {
            'hands' => [
              0, 255, 0
            ]
          }
        }
        expect(Clock).to receive(:colours).with ({
          'hours' => {
            'hands' => [
              0, 255, 0
            ]
          }
        })
        ClockWorker.drain
      end
    end

    context 'get colours' do
      it 'returns a colour' do
        get '/colours/hours/hands', nil, JSON_HEADERS
        expect(last_response).to be_ok
        expect(JSON.parse last_response.body).to eq (
          {
            'colour' => [
              255, 0, 0
            ]
          }
        )
      end
    end
  end
end
