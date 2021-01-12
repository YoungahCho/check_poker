require 'rails_helper'

describe 'PokerAPI', type: :request do
  context 'correct request'
  params = {cards: ['S12 C12 D12 S5 C3', 'D11 S11 S10 C10 S9', 'C7 C6 C5 C4 C3'] }

  it 'check the hand & best card' do
    post '/api/v1/poker/check_cards', params: params
    json = JSON.parse(response.body)

    expect(response.status).to eq(201)

    expect(json['result'][0]['card']).to eq('S12 C12 D12 S5 C3')
    expect(json['result'][0]['hand']).to eq('Three of a kind')
    expect(json['result'][0]['best']).to eq(false)

    expect(json['result'][1]['card']).to eq('D11 S11 S10 C10 S9')
    expect(json['result'][1]['hand']).to eq('Two pair')
    expect(json['result'][1]['best']).to eq(false)

    expect(json['result'][2]['card']).to eq('C7 C6 C5 C4 C3')
    expect(json['result'][2]['hand']).to eq('Straight Flush')
    expect(json['result'][2]['best']).to eq(true)
  end
end

context 'incorrect params name' do
  params = { car: ['S12 C12 D12 S5 C3', 'D11 S11 S10 C10 S9'] }

  it 'report 400 error' do
    post '/api/v1/poker/check_cards', params: params
    json = JSON.parse(response.body)

    expect(response.status).to eq(400)
  end
end

context 'incorrect params' do
  params = { cards: ['S1 S2 S3 S4 S5', 'X1 D6 s10 C6'] }

  it 'return result & error' do
    post '/api/v1/poker/check_cards', params: params
    json = JSON.parse(response.body)

    expect(json['result'][0]['card']).to eq(params[:cards][0])
    expect(json['result'][0]['hand']).to eq('Straight Flush')
    expect(json['result'][0]['best']).to eq(true)

    expect(json['error'][0]['card']).to eq(params[:cards][1])
    expect(json['error'][0]['msg']).to eq('カードが5枚未満です。')

    expect(json['error'][1]['card']).to eq(params[:cards][1])
    expect(json['error'][1]['msg']).to eq('1番目のカード指定文字が不正です。(X1)')

    expect(json['error'][2]['card']).to eq(params[:cards][1])
    expect(json['error'][2]['msg']).to eq('3番目のカード指定文字が不正です。(s10)')

    expect(json['error'][3]['card']).to eq(params[:cards][1])
    expect(json['error'][3]['msg']).to eq('5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）')
  end
end

