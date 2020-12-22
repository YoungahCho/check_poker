module Poker
  class Check_cards < Grape::API
    version 'v1', using: :path
    format :json

    resource :poker do
      desc '判定ロジック'
      post 'check_cards' do
        params[:cards]
        response = {}
        check_result = []
        errors = []

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
              'hand' => CheckService.check_cards(cards)
              # 'best' => CheckService.check_best(hand_score)
            }
            check_result.push(result_hash)
            end

          if errors.present?
            response[:error] = errors
          else
            response[:result] = check_result
          end
        end

        return response
      end
    end
  end
end
