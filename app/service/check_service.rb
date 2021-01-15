module CheckService

  def self.check_cards(cards)
    card = make_cards_array(cards)
    judge_cards(card)
  end

  # 配列を作る
  def self.make_cards_array(cards)

    splited_cards = cards.split(/[[:space:]]/)
    splited_cards.map do |cards_char|
      [cards_char[0], cards_char[1..2].to_i]
    end
  end

  # 配列を判定する
  def self.judge_cards(card)

    # 同じスートなのか確認
    suits = card.map { |c| c[0] }
    is_same_suit = suits.uniq.length == 1

    # 連続する数字か確認
    # ①カードの数字を並び変える
    numbers = card.map { |c| c[1] }.sort!

    # ②並べ替えたrankの配列が連続する数字か確認する
    is_sequence_rank = false
    numbers.each_cons(2) do |nums|
      if nums[0] + 1 != nums[1]
        is_sequence_rank = false
        break
      else
        is_sequence_rank = true
      end
    end

    # 同じ数字のカードが何枚あるか確認
    uniq_numbers = numbers.uniq
    same_numbers = uniq_numbers.map { |n| numbers.count(n) }

    # 昇順に並べる
    same_numbers.sort!

    # 最終カード判定
    @check_result =  if is_same_suit && is_sequence_rank
                       'Straight Flush'
                     elsif same_numbers == [1, 4]
                       'Four of a kind'
                     elsif same_numbers == [2, 3]
                       'Full house'
                     elsif is_same_suit
                       'Flush'
                     elsif is_sequence_rank
                       'Straight'
                     elsif same_numbers == [1, 1, 3]
                       'Three of a kind'
                     elsif same_numbers == [1, 2, 2]
                       'Two pair'
                     elsif same_numbers == [1, 1, 1, 2]
                       'One pair'
                     else
                       'High card'
                     end
  end
end

