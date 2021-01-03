module Poker
  class CheckCards < Grape::API
    version 'v1', using: :path
    format :json

    resource :poker do
      desc '判定ロジック'
      post 'check_cards' do
        cards_array = params[:cards]
        # cards_array = ["D12 H4 S4 C2 D13", "S10 S9 S12 S7 S13"]
        response = {}
        check_results = []
        errors = []

        cards_array.each do |cards|
          error_msgs = ValidateService.validate_cards(cards)

          if error_msgs.present?
            # 変数に入れた方がいい
            # メソッドの結果を2回呼び出すことになっている
            error_msgs.each do |msg|
              error_hash = {
                'cards' => cards,
                'msg' => msg
                # 에러 메세지의 배열에서 each문을 돌려라
                # 에러메세지는 배열이 아니라 스트링으로 리스폰스
                # hash를 여러개로 만들 필요가 있음 h
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

        hands = check_results.map { |result_hash| result_hash['hand'] }
        # hands = ["One pair", "Flush"]

        score = {
          'Straight Flush' => 9,
          'Four of a kind'=> 8,
          'Full house'=> 7,
          'Flush'=> 6,
          'Straight'=> 5,
          'Three of a kind'=>4,
          'Two pair'=>3,
          'One pair'=> 2,
          'High card'=>1
        }

        # scores = [ 2, 6 ]
        scores = hands.map { |hand| score[hand] }
        best_card = score.key(scores.max)


        check_results.each do |check_result|
          if check_result["hand"] == best_card
            check_result["best"] = true
          else
            check_result["best"] = false
          end
        end

        if errors.present?
         response[:result] = check_results
         response[:error] = errors
        else
          response[:result] = check_results
        end

        return response

      end
    end
  end
  end