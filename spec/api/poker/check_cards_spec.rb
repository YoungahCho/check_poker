require 'rails_helper'

describe 'PokerAPI', type: :request do
  describe 'check_cards' do

    context 'correct request' do
      let(:params) { { cards: ['S12 C12 D12 S5 C3', 'D11 S11 S10 C10 S9', 'C7 C6 C5 C4 C3'] } }

      it 'check the hand & best card' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)

        expect(response.status).to eq(201)

        expect(json['results'].size).to eq 3
        expect(json['results']).to include({ 'card' => 'S12 C12 D12 S5 C3', 'hand' => 'Three of a kind', 'best' => false })
        expect(json['results']).to include({ 'card' => 'D11 S11 S10 C10 S9', 'hand' => 'Two pair', 'best' => false })
        expect(json['results']).to include({ 'card' => 'C7 C6 C5 C4 C3', 'hand' => 'Straight Flush', 'best' => true })
      end
    end

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
        expect(json['error']).to eq([{ 'msg' => 'リクエストのbodyが配列ではありません。' }])
      end
    end

    context 'request not string' do
      let(:params) { { cards: [123] } }
      it 'report 400 error' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)

        expect(response.status).to eq(400)
        expect(json['error']).to eq([{ 'msg' => '配列の要素123が文字列ではありません。' }])
      end
    end

    context 'correct params & incorrect params' do
      let(:params) { { cards: ['S1 S2 S3 S4 S5', 'X1 D6 s10 C6'] } }

      it 'return result & error' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)
        expect(json['results'].size).to eq 1
        expect(json['results']).to include({ 'card' => params[:cards][0], 'hand' => 'Straight Flush', 'best' => true })

        expect(json['errors'].size).to eq 5
        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => 'カードが5枚ではありません。' })
        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => '1番目のカード指定文字が不正です。(X1)' })
        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => '3番目のカード指定文字が不正です。(s10)' })
        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）' })
        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' })
      end
    end

    context 'all incorrect params' do
      let(:params) { { cards: ['S1 S2 S3　S4 S5', 'H5 S12 D10 C6 T1'] } }
      it 'return errors' do
        post '/api/v1/poker/check_cards', params: params, as: :json
        json = JSON.parse(response.body)

        expect(json['errors'].size).to eq 7
        expect(json['errors']).to include({ 'card' => params[:cards][0], 'msg' => 'カードが5枚ではありません。' })
        expect(json['errors']).to include({ 'card' => params[:cards][0], 'msg' => '3番目のカード指定文字が不正です。(S3　S4)' })
        expect(json['errors']).to include({ 'card' => params[:cards][0], 'msg' => '全角スペースが含まれています。(S3　S4)' })
        expect(json['errors']).to include({ 'card' => params[:cards][0], 'msg' => '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）' })
        expect(json['errors']).to include({ 'card' => params[:cards][0], 'msg' => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' })

        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => '5番目のカード指定文字が不正です。(T1)' })
        expect(json['errors']).to include({ 'card' => params[:cards][1], 'msg' => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' })
      end

    end
  end
end
