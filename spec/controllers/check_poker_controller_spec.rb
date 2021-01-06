require 'rails_helper'

RSpec.describe CheckPokerController, type: :controller do
  describe `#input_cards` do
    it `render the :input_cards template` do
      get :input_cards
      expect(response).to be_success
    end
  end
end
