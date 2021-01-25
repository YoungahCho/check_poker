require 'rails_helper'

RSpec.describe ValidateService do
  describe 'validate_cards' do
    let!(:error) { ValidateService.validate_cards(cards) }

    context 'incorrect suit' do
      let(:cards) { 'A5 D6 H6 S10 C6' }
      it 'response suit error' do
        expect(error.size).to eq 2
        expect(error).to include '1番目のカード指定文字が不正です。(A5)'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context 'incorrect number' do
      let(:cards) { 'D9 H1 S11 S19 C3' }
      it 'response number error' do
        expect(error.size).to eq 2
        expect(error).to include '4番目のカード指定文字が不正です。(S19)'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context 'include same card' do
      let(:cards) { 'H7 H9 S12 D6 D6' }
      it 'response overlap error' do
        expect(error.size).to eq 2
        expect(error).to include 'カードが重複しています。(["D6"])'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context 'less 5 cards' do
      let(:cards) { 'D3 D6 S10 C6' }
      it 'response less array error' do
        expect(error.size).to eq 3
        expect(error).to include 'カードが5枚ではありません。'
        expect(error).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context 'over 5 cards' do
      let(:cards) { 'D3 D6 S10 C6 C5 H6' }
      it 'response over array error' do
        expect(error.size).to eq 3
        expect(error).to include 'カードが5枚ではありません。'
        expect(error).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context 'space request' do
      let(:cards) { ' ' }
      it 'response input error' do
        expect(error.size).to eq 4
        expect(error).to include '入力されたカードがありません。'
        expect(error).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(error).to include 'カードが5枚ではありません。'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context 'full-width space' do
      let(:cards) { 'S12 D4 H6 H8　D9' }
      it 'response space error' do
        expect(error.size).to eq 5
        expect(error).to include 'カードが5枚ではありません。'
        expect(error).to include '4番目のカード指定文字が不正です。(H8　D9)'
        expect(error).to include '全角スペースが含まれています。(H8　D9)'
        expect(error).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end

    context '4 cards, incorrect number' do
      let(:cards) { 'D4 H6 S19 C3' }
      it 'response less 5 cards error, number error' do
        expect(error.size).to eq 4
        expect(error).to include 'カードが5枚ではありません。'
        expect(error).to include '3番目のカード指定文字が不正です。(S19)'
        expect(error).to include '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
        expect(error).to include '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
      end
    end
  end
end


