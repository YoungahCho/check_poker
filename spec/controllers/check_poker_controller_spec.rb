require 'rails_helper'

RSpec.describe CheckPokerController, type: :controller do
  describe 'top page' do

    # get
    it 'render page' do
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

    # view
    it 'show page' do
      post :input_cards
      expect(response).to have_http_status '200'
    end
  end

  # インスタンス変数
  describe 'Check the cards' do
    let(:params) { {cards: 'S1 S2 S3 S4 S5'} }

    it '@check_result' do
      expect(assigns(:check_result)).to eq 'Straight Flush'
    end

    it '@cards' do
      expect(assigns(:cards)).to eq 'S1 S2 S3 S4 S5'
    end

    it '@errors blank' do
      expect(assigns(:errors)).to eq nil
    end

    it 'check_cards' do
      post :input_cards, params: params
      expect(response).to be_successful
    end
  end

  describe 'Check the error' do
    let(:params) { {cards: 'S1 S2 S3 S4 S19' }}

    it '@errors_1' do
      expect(assigns(:errors)).to eq '5番目の番目のカード指定文字が不正です。(S19)'
    end

    # it `@errors_2` do
    #   expect(assigns(:errors)).to eq '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
    # end
  end
end
