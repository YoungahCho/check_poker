require 'rails_helper'

RSpec.describe CheckService do
  describe 'judge the hand' do
    context 'all same suit, sequence number' do
      cards = 'S1 S2 S3 S4 S5'

      it 'Straight Flush' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Straight Flush'
      end
    end

    context '4 same rank' do
      cards = 'D5 D6 H6 S6 C6'

      it 'Four of a kind' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Four of a kind'
      end
    end

    context '3 same rank & 2 same rank' do
      cards =  'H9 C9 S9 H1 C1'

      it 'Four of a kind' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Full house'
      end
    end

    context 'all same suit' do
      cards =  'S13 S12 S11 S9 S6'

      it 'Flush' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Flush'
      end
    end

    context 'sequence number' do
      cards = 'D6 S5 D4 H3 C2'

      it 'Straight' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Straight'
      end
    end

    context '3 same rank' do
      cards = 'S12 C12 D12 S5 C3'

      it 'Three of a kind' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Three of a kind'
      end
    end

    context '2 same rank & 2 same rank' do
      cards = 'D11 S11 S10 C10 S9'

      it 'Two pair' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'Two pair'
      end
    end

    context '2 same rank' do
      cards = 'C10 S10 S6 H4 H2'

      it 'One pair' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'One pair'
      end
    end

    context 'no pair' do
      cards = 'CD1 D10 S9 C5 C4'

      it 'High card' do
        result = CheckService.check_cards(cards)
        expect(result).to eq 'High card'
      end
    end

  end

end
