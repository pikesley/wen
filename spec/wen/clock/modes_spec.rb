module Wen
  describe Clock do
    it 'sets the mode' do
      described_class.mode = 'range'
      expect($redis.get 'clock-mode').to eq 'range'
    end
  end
end
