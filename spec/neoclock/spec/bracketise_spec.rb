module Neoclock
  describe Clock do
    context 'bracketise' do
      it 'handles the easy case' do
        expect(described_class.bracketise 2, 5).to eq [ 1, 2, 3 ]
      end

      it 'handles the low-end case' do
        expect(described_class.bracketise 0, 5).to eq [ 0, 1, 4 ]
      end

      it 'handles the high-end case' do
        expect(described_class.bracketise 4, 5).to eq [0, 3, 4]
      end

      it 'handles the last-but-one case' do
        expect(described_class.bracketise 23, 24).to eq [0, 22, 23]
      end
    end
  end
end
