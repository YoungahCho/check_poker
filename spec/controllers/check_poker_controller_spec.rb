require 'rails_helper'

RSpec.describe CheckPokerController, type: :controller do

  context 'get' do
    it 'render page' do
      get :new
      expect(response).to be_successful
    end

    # view
    it 'show page' do
      get :new
      expect(response).to have_http_status (200)
    end
  end

  context 'post' do
    it 'post params' do
      post :new
      expect(response).to be_successful
    end

    # view
    it 'show page' do
      post :new
      expect(response).to have_http_status (200)
    end
  end
end

