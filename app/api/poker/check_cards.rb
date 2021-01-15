module Poker

  require 'grape'

  class CheckCards < Grape::API
    version 'v1', using: :path
    format :json

    resource :poker do

      params do
        requires :cards, message: 'をパラメーター名にしてください'
      end

      desc '判定ロジック'
      post 'check_cards' do

        cards_strs = params[:cards]

        # cards_str = ["D12 H4 S4 C2 D13", "S10 S9 S12 S7 S13"]
        response = {}
        check_results = []
        errors = []

        #paramsのバリデーション
        not_array = !(cards_strs.is_a?(Array))
        error!([{ 'msg' => 'リクエストのbodyが配列ではありません。' }], 400) if not_array
        not_strings = cards_strs.reject { |a| a.is_a?(String) }
        error!([{ 'msg' => "配列の要素#{not_strings.join(', ')}が文字列ではありません。" }], 400) if not_strings.present?

        cards_strs.each do |cards|
          error_msgs = ValidateService.validate_cards(cards)

          if error_msgs.present?
            error_msgs.each do |msg|
              error_hash = {
                'card' => cards,
                'msg' => msg
              }
              errors.push(error_hash)
            end
          else
            result_hash = {
              'card' => cards,
              'hand' => CheckService.check_cards(cards),
            }
            check_results.push(result_hash)
          end
        end

        check_results = CheckCards.add_best_result(check_results)

        response[:result] = check_results
        response[:error] = errors

        return response

      end
    end

    def self.add_best_result(check_results)
      # メソッド名を変える　add_best_result などなど

      hands = check_results.map { |result_hash| result_hash['hand'] }
      # hands = ["One pair", "Flush"]

      score = {
        'Straight Flush' => 90,
        'Four of a kind' => 80,
        'Full house' => 70,
        'Flush' => 60,
        'Straight' => 50,
        'Three of a kind' => 40,
        'Two pair' => 30,
        'One pair' => 20,
        'High card' => 10
      }

      # scores = [ 2, 6 ]
      scores = hands.map { |hand| score[hand] }
      best_card = score.key(scores.max)

      check_results.each do |check_result|
        check_result['best'] = check_result['hand'] == best_card
      end
      check_results
    end

  end
end