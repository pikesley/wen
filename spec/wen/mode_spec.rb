module Wen
  describe App do
    context 'set the mode' do
      it 'sets the mode' do
        post '/mode', { mode: 'vague' }.to_json, JSON_HEADERS
        expect(ClockWorker).to have_enqueued_job 'mode', {
          mode: 'vague'
        }
        expect(Clock).to receive(:mode=).with 'vague'
        ClockWorker.drain
      end
    end
  end
end
