require 'rails_helper'

describe 'PokerAPI', type: :request do

  describe 'correct request' do
    let(:params) { { cards: ['S12 C12 D12 S5 C3', 'D11 S11 S10 C10 S9', 'C7 C6 C5 C4 C3'] } }

    it 'check the hand & best card' do
      post '/api/v1/poker/check_cards', params: params, as: :json
      json = JSON.parse(response.body)

      expect(response.status).to eq(201)

      expect(json['result'].size).to eq 3
      expect(json['result']).to include({ 'card' => 'S12 C12 D12 S5 C3', 'hand' => 'Three of a kind', 'best' => false })
      expect(json['result']).to include({ 'card' => 'D11 S11 S10 C10 S9', 'hand' => 'Two pair', 'best' => false })
      expect(json['result']).to include({ 'card' => 'C7 C6 C5 C4 C3', 'hand' => 'Straight Flush', 'best' => true })
    end
  end

  describe 'API error check' do

    context 'incorrect params name' do
      let(:params) { { car: ['S12 C12 D12 S5 C3', 'D11 S11 S10 C10 S9'] } }
      it 'report 400 error' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)

        expect(response.status).to eq(400)
        expect(json['error']).to eq('cards をパラメーター名にしてください')
      end
    end

    context 'request not array ' do
      let(:params) { { cards: 123 } }
      it 'report 400 error' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)
        expect(response.status).to eq(400)
        expect(json['messages']).to eq('リクエストのbodyが配列ではありません。')
      end
    end

    context 'request not string' do
      let(:params) { { cards: [123] } }
      it 'report 400 error' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)

        expect(response.status).to eq(400)
        expect(json['messages']).to eq('配列の要素123が文字列ではありません。' )
      end
    end

  end

  describe 'incorrect params' do

    context 'correct params & incorrect params' do
      let(:params) { { cards: ['S1 S2 S3 S4 S5', 'X1 D6 s10 C6'] } }

      it 'return result & error' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)
        expect(json['result'].size).to eq 1
        expect(json['result']).to include({ 'card' => params[:cards][0], 'hand' => 'Straight Flush', 'best' => true })

        expect(json['error'].size).to eq 5
        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => 'カードが5枚未満です。' })
        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => '1番目のカード指定文字が不正です。(X1)' })
        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => '3番目のカード指定文字が不正です。(s10)' })
        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）' })
        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' })
      end
    end

    context 'all incorrect params' do
      let(:params) { { cards: ['S1 S2 S3　S4 S5', 'H5 S12 D10 C6 T1'] } }
      it 'return errors' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)

        expect(json['error'].size).to eq 7
        expect(json['error']).to include({ 'card' => params[:cards][0], 'msg' => 'カードが5枚未満です。' })
        expect(json['error']).to include({ 'card' => params[:cards][0], 'msg' => '3番目のカード指定文字が不正です。(S3　S4)' })
        expect(json['error']).to include({ 'card' => params[:cards][0], 'msg' => '全角スペースが含まれています。(S3　S4)' })
        expect(json['error']).to include({ 'card' => params[:cards][0], 'msg' => '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）' })
        expect(json['error']).to include({ 'card' => params[:cards][0], 'msg' => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' })

        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => '5番目のカード指定文字が不正です。(T1)' })
        expect(json['error']).to include({ 'card' => params[:cards][1], 'msg' => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' })
      end

    end
  end
end



