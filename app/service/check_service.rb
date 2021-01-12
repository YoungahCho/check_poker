module CheckService

  def self.check_cards(cards)
    cards_arr = make_cards_array(cards)
    judge_cards(cards_arr)
  end

  # 配列を作る
  def self.make_cards_array(cards)
    arr = []
    first_index = 0
    second_index = 0
    str = ''
    # suitとrankの二つの列がある２次元配列を作成する
    cards_array = Array.new(5) { Array.new(2) { 0 } }

    # suitとrankに分けて配列に入れる
    (0..cards.length - 1).each do |i|
      # iが0から始まるので、最後のn番目のi=n-1までロジックに入れる

      if cards[i] == ' '
        first_index += 1
        second_index = 0
        str = ''
        # 半角スペースが配列に入る場合、次の配列に入れる
      elsif second_index.zero?
        cards_array[first_index][second_index] = cards[i]
        # cardsArr[i][0]の配列の箱にcards[i]を入れる
        second_index += 1
        # i番目がsuitの場合
        # suiteの次のrankの位置にいく
      else
        # cards[i]がrankの場合
        str.concat(cards[i])
        # str = ""にcards[i]の文字を追加する
        cards_array[first_index][second_index] = str
        # 配列の[i,1]にcards[i]を入れたstrを入れる
      end
    end
    cards_array
  end

  # 配列を判定する
  def self.judge_cards(card_arr)
    cards_array = card_arr

    # 判定ロジックの変数
    is_straight_flush = false
    is_four_of_a_kind = false
    is_full_house = false
    is_flush = false
    is_straight = false
    is_three_of_a_kind = false
    is_two_pair = false
    is_one_pair = false

    is_same_suit = false
    is_sequence_rank = false
    rank_array = []
    
    # 1番目のスートを基準にする
    suit = cards_array[0][0]

    # 同じスートがあるか確認する
    (1..cards_array.length - 1).each do |i|
      if suit != cards_array[i][0]
        is_same_suit = false
        break
      else
        is_same_suit = true
      end
    end

    # 連続する数字か確認
    # ①カードの数字を並び変える
    (0..cards_array.length - 1).each do |i|
      rank_array[i] = cards_array[i][1].to_i
      # 文字列で受け取ったrankをintegerで変換
      rank_array = rank_array.sort
      # rankの配列を昇順で並べる
    end

    # ②並べ替えたrankの配列が連続する数字か確認する
    (0..rank_array.length - 2).each do |i|
      if rank_array[i] + 1 == rank_array[i + 1]
        is_sequence_rank = true
      else
        is_sequence_rank = false
        break
      end
    end

    # Straight Flush, Flush, Straight確認
    is_straight_flush = true if is_same_suit && is_sequence_rank

    is_flush = true if is_same_suit

    is_straight = true if is_sequence_rank

    # 同じ数字のカードが何枚あるか確認
    same_rank_array = []

    (0..rank_array.length - 1).each do |i|
      same_rank_array.push(rank_array.count(rank_array.uniq[i]))
      same_rank_array.delete(0)
    end

    # 昇順に並べる
    same_rank_array = same_rank_array.sort

    # その他のカード確認
    case same_rank_array
    when [1, 4]
      is_four_of_a_kind = true
    when [2, 3]
      is_full_house = true
    when [1, 1, 3]
      is_three_of_a_kind = true
    when [1, 2, 2]
      is_two_pair = true
    when [1, 1, 1, 2]
      is_one_pair = true
    end

    # 最終カード判定
    @check_result = if is_straight_flush
                      'Straight Flush'
                    elsif is_four_of_a_kind
                      'Four of a kind'
                    elsif is_full_house
                      'Full house'
                    elsif is_flush
                      'Flush'
                    elsif is_straight
                      'Straight'
                    elsif is_three_of_a_kind
                      'Three of a kind'
                    elsif is_two_pair
                      'Two pair'
                    elsif is_one_pair
                      'One pair'
                    else
                      'High card'
                    end
  end
end
