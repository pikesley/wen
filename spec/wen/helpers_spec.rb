class TestHelper
  include Wen::Helpers
end

module Wen
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'gets a page title' do
      expect(helpers.get_title 'modes').to eq 'Clock Modes'
    end

    it 'titlecases a string' do
      expect(helpers.titlecase 'clock modes').to eq 'Clock Modes'
    end

    context 'next and previous' do
      it 'works for the easy case' do
        expect(helpers.next_and_previous 'tricks').to eq ({
          next: 'about',
          previous: 'modes'
        })
      end

      it 'handles the low-end case' do
        expect(helpers.next_and_previous 'colours').to eq ({
          next: 'modes',
          previous: nil
        })
      end

      it 'handles the top-end case' do
        expect(helpers.next_and_previous 'about').to eq ({
          next: nil,
          previous: 'tricks'
        })
      end
    end
  end
end
