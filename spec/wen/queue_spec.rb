module Wen
  describe App do
    context 'priorities' do
      it 'processes in the correct order' do
        post '/tricks', { trick: 'shuffle' }.to_json, JSON_HEADERS
        post '/tricks', { trick: 'chaos' }.to_json, JSON_HEADERS
        post '/modes', { mode: 'strict' }.to_json, JSON_HEADERS

        expect(TrickWorker).to have_enqueued_job({'trick' => 'shuffle'})
        expect(TrickWorker).to have_enqueued_job({'trick' => 'chaos'})
        expect(ModeWorker).to have_enqueued_job({'mode' => 'strict'})

        expect(Clock::Tricks).to receive(:shuffle)
        expect(Clock).to receive(:mode=).with 'strict'
        expect(Clock::Tricks).to receive(:chaos)

        TrickWorker.drain
        ModeWorker.drain
      end
    end
  end
end
