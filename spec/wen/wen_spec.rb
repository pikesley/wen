module Wen
  describe App do
    it 'has a display page' do
      get '/colours/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /colours/
    end

    it 'requests the time' do
      post '/time', nil, JSON_HEADERS
      expect(ClockWorker).to have_enqueued_job 'time'
    end

    it 'shuffles' do
      post '/tricks', { trick: 'shuffle' }.to_json, JSON_HEADERS
      expect(ClockWorker).to have_enqueued_job 'tricks', {'trick' => 'shuffle'}
      expect(Clock::Tricks).to receive(:shuffle)
      ClockWorker.drain
    end

    it 'has a config' do
      expect(Wen::Config.instance.config).to be_a OpenStruct
    end

    it 'stores defaults' do
      Wen.stash_defaults
      expect($redis.get 'hours/hands').to eq "255, 0, 0"
      expect($redis.get 'clock-mode').to eq 'range'
    end
  end
end
