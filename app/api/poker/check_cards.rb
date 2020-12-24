module Poker
  class CheckCards < Grape::API
    version 'v1', using: :path
    format :json

    resource :poker do
      desc '判定ロジック'
      post 'check_cards' do
        params[:cards]
        # cards = ["D2 H5 H4 C2 D13", "S10 S9 S13 S7 S13"]
        response = {}
        check_result = []
        errors = []

        # hands = params[:cards].map { |cards| CheckService.check_cards(cards) }

        params[:cards].each do |cards|
          if ValidateService.validate_cards(cards).any?
            error_hash = {
              'cards' => cards,
              'msg' => ValidateService.validate_cards(cards)
            }
            errors.push(error_hash)
          else
            result_hash = {
              'card' => cards,
              'hand' => CheckService.check_cards(cards),
            }
            check_result.push(result_hash)
          end

          response[:result] = check_result
          response[:error] = errors
          # response[:result] = [{"card"=>"D2 H5 H4 C2 D13", "hand"=>"One pair"}]
          # [{"card"=>"D2 H5 H4 C2 D13", "hand"=>"One pair"}]
        end

        hands = response[:result].map { |result_hash| result_hash['hand'] }
        print hands


        # with_index
        if best_index do
          response[:best] = value
        end

        return response
      end
    end
  end
  end
end



