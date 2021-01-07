require 'rails_helper'

RSpec.describe ValidateService do
  describe 'validation' do

    describe 'card error' do
      let(:cards) { 'A5 D6 D6 S16 C6' }
      it 'suit error' do
        result = ValidateService.validate_cards(cards)
        expect(result[0]).to eq '1番目のカード指定文字が不正です。(A5)'
      end
      it 'rank error' do
        result = ValidateService.validate_cards(cards)
        expect(result[1]).to eq '4番目のカード指定文字が不正です。(S16)'
      end
      it 'overlap error' do
        result = ValidateService.validate_cards(cards)
        expect(result[2]).to eq 'カードが重複しています。(["D6"])'
      end
    end

    describe 'array error' do

      describe 'less 5 cards' do
        let(:cards) { 'D3 D6 S10 C6' }
        it 'less 5 cards' do
          result = ValidateService.validate_cards(cards)
          expect(result[0]).to eq 'カードが5枚未満です。'
        end
        it 'input the 5 cards' do
          result = ValidateService.validate_cards(cards)
          expect(result[1]).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        end
      end

      describe 'over 5 cards' do
        let(:cards) { 'D3 D6 S10 C6 C5 H6' }
        it 'over array error' do
          result = ValidateService.validate_cards(cards)
          expect(result[0]).to eq 'カードが5枚超過です。'
        end
        it 'input the 5 cards' do
          result = ValidateService.validate_cards(cards)
          expect(result[1]).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        end
      end
    end

    describe 'empty error' do
      let(:cards) { ' ' }
      it 'input error' do
        result = ValidateService.validate_cards(cards)
        expect(result[0]).to eq '入力されたカードがありません。'
      end
      it 'input error' do
        result = ValidateService.validate_cards(cards)
        expect(result[1]).to eq '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
      end
      end
    end

  end
