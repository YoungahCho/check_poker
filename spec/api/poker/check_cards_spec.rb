require 'rails_helper'

describe 'PokerAPI', type: :request do
  context 'correct request'
  params = { cards: ['S12 C12 D12 S5 C3', 'D11 S11 S10 C10 S9
', 'C7 C6 C5 C4 C3']}

  it 'check the hand & best card' do
    post '/api/poker/judge', params: params
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
  end
end