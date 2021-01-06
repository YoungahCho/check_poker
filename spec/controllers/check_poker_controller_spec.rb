require 'rails_helper'

RSpec.describe CheckPokerController, type: :controller do
  describe `top page` do

    # get
    it `render page` do
      get :input_cards
      expect(response).to be_successful
    end

    # view
    it 'show page' do
      get :input_cards
      expect(response).to have_http_status '200'
    end

    # post
    it 'post params' do
      post :input_cards
      expect(response).to be_successful
    end
  end

  # paramsの処理
  describe 'Check the cards', type: :request do
    let(:params) { { cards: 'S1 S2 S3 S4 S5' } }
    it 'check_cards' do
      post :input_cards, params: params
      expect(response).to eq be_successful
    end
  end
end
