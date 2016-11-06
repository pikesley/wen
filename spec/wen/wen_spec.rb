module Wen
  describe App do
    it 'has a display page' do
      get '/colours/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /svg/
    end

    it 'requests the time' do
      post '/time', nil, JSON_HEADERS
      expect(TimeWorker).to have_enqueued_job
      expect(Clock).to receive(:time)
      TimeWorker.drain
    end

    it 'shuffles' do
      post '/tricks', { trick: 'shuffle' }.to_json, JSON_HEADERS
      expect(TrickWorker).to have_enqueued_job({'trick' => 'shuffle'})
      expect(Clock::Tricks).to receive(:shuffle)
      TrickWorker.drain
    end

    it 'has a config' do
      expect(Wen::Config.instance.config).to be_a OpenStruct
    end

    it 'stores defaults' do
      Wen.stash_defaults
      expect($redis.get 'hours/hand').to eq "#{$hand_colour.join ', '}"
      expect($redis.get 'clock-mode').to eq 'range'
    end
  end
end
