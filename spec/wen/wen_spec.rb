module Wen
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    it 'has a display page' do
      get '/display'
      expect(last_response).to be_ok
      expect(last_response.body).to match /clock control/
    end

    it 'sets the time' do
      patch '/display', { mode: 'time' }.to_json, JSON_HEADERS
      expect(ClockWorker).to have_enqueued_job 'display', {'mode' => 'time'}
    end

    it 'shuffles' do
      patch '/display', { mode: 'shuffle' }.to_json, JSON_HEADERS
      expect(ClockWorker).to have_enqueued_job 'display', {'mode' => 'shuffle'}
      expect(Clock).to receive(:shuffle)
      ClockWorker.drain
    end

    it 'has a config' do
      expect(Wen::Config.instance.config).to be_a OpenStruct
    end

    it 'stores colours' do
      Wen.stash_colours
      expect($redis.get 'hours/hands').to eq "255, 0, 0"
    end
  end
end
