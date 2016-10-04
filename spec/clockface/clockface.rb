module Clockface
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    it 'says hello' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /Hello from Clockface/
    end

    it 'serves JSON' do
      get '/', nil, JSON_HEADERS
      expect(last_response).to be_ok
      expect(JSON.parse last_response.body).to eq (
        {
          'app' => 'Clockface'
        }
      )
    end

    it 'sets the time' do
      patch '/display', { mode: 'time' }.to_json, JSON_HEADERS
      expect(ClockWorker).to have_enqueued_job 'display', {'mode' => 'time'}
    end

    it 'shuffles' do
      patch '/display', { mode: 'shuffle' }.to_json, JSON_HEADERS
      expect(ClockWorker).to have_enqueued_job 'display', {'mode' => 'shuffle'}
    end
  end
end
