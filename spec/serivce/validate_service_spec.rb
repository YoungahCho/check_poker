require 'rails_helper'

RSpec.describe ValidateService do
  describe 'validation' do

    describe 'card error' do

      context 'incorrect suit' do
        let(:cards) { 'A5 D6 H6 S10 C6' }
        it 'response suit error' do
          result = ValidateService.validate_cards(cards)
          expect(result.size).to eq 2
          expect(result).to include '1番目のカード指定文字が不正です。(A5)'
          expect(result).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
        end
      end

      context 'incorrect number' do
        let(:cards) { 'D9 H1 S11 S19 C3' }
        it 'response number error' do
          result = ValidateService.validate_cards(cards)
          expect(result.size).to eq 2
          expect(result).to include '4番目のカード指定文字が不正です。(S19)'
          expect(result).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
        end
      end

      context 'include same card' do
        let(:cards) { 'H7 H9 S12 D6 D6' }
        it 'response overlap error' do
          result = ValidateService.validate_cards(cards)
          expect(result.size).to eq 1
          expect(result).to eq ['カードが重複しています。(["D6"])']
        end
      end
    end

    describe 'array error' do

      context 'less 5 cards' do
        let(:cards) { 'D3 D6 S10 C6' }
        it 'response less array error' do
          result = ValidateService.validate_cards(cards)
          expect(result.size).to eq 2
          expect(result).to include 'カードが5枚未満です。'
          expect(result).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        end
      end

      context 'over 5 cards' do
        let(:cards) { 'D3 D6 S10 C6 C5 H6' }
        it 'response over array error' do
          result = ValidateService.validate_cards(cards)
          expect(result.size).to eq 2
          expect(result).to include 'カードが5枚超過です。'
          expect(result).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        end
      end
    end

    describe 'request empty' do
      let(:cards) { ' ' }
      it 'response input error' do
        result = ValidateService.validate_cards(cards)
        expect(result.size).to eq 2
        expect(result).to include '入力されたカードがありません。'
        expect(result).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
      end
    end

    describe 'include full-width space ' do
      let(:cards) { 'S12 D4 H6 H8　D9' }
      it 'response space error' do
        result = ValidateService.validate_cards(cards)
        expect(result.size).to eq 5
        expect(result).to include 'カードが5枚未満です。'
        expect(result).to include '4番目のカード指定文字が不正です。(H8　D9)'
        expect(result).to include '全角スペースが含まれています。(H8　D9)'
        expect(result).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(result).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    describe 'request multiple error' do
      let(:cards) { 'D4 H6 S19 C3' }
      it 'response less 5 cards error, number error' do
        result = ValidateService.validate_cards(cards)
        expect(result.size).to eq 4
        expect(result).to include 'カードが5枚未満です。'
        expect(result).to include '3番目のカード指定文字が不正です。(S19)'
        expect(result).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(result).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end
  end

end


