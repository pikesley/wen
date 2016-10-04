module Wen
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    context 'set colours' do
      it 'sets the time' do
        patch '/colours', { hours: {figure: [0, 255, 0] } }.to_json, JSON_HEADERS
        expect(ClockWorker).to have_enqueued_job 'colours', {
          'hours' => {
            'figure' => [
              0, 255, 0
            ]
          }
        }
        expect(Clock).to receive(:colours).with ({
          'hours' => {
            'figure' => [
              0, 255, 0
            ]
          }
        })
        ClockWorker.drain
      end
    end
  end
end
