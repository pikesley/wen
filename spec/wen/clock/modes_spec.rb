module Wen
  describe Clock do
    it 'sets the mode' do
      described_class.mode = 'range'
      expect($redis.get 'clock_mode').to eq 'range'
    end
  end
end
