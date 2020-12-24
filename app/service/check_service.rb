module CheckService

  def self.check_cards(cards)


    # judge the card
    # カードを入れる配列を宣言する
    arr = []
    first_index = 0
    second_index = 0
    str = ''
    # suitとrankの二つの列がある２次元配列を作成する
    cards_array = Array.new(5){Array.new(2){0}}

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

    suit = cards_array[0][0]
    # 最初のsuitを基準にする

    (1..cards_array.length - 1).each do |i|

      if suit != cards_array[i][0]
        is_same_suit = false
        break
      else
        is_same_suit = true
      end
    end


    (0..cards_array.length - 1).each do |i|
      # iが0から始まるので、最後のn番目のi=n-1までロジックに入れる
      rank_array[i] = cards_array[i][1].to_i
      # 文字列で受け取ったrankをintegerで変換
      rank_array = rank_array.sort
      # rankの配列を昇順で並べる
    end


    # 並べ替えたrankの配列は連続する数字か確認する
    (0..rank_array.length - 2).each do |i|
      if rank_array[i] + 1 == rank_array[i + 1]
        is_sequence_rank = true
      else
        is_sequence_rank = false
        break
      end
    end

    # Straight Flush, Flush, Straight
    if is_same_suit && is_sequence_rank
      is_straight_flush = true
    end

    if is_same_suit
      is_flush = true
    end

    if is_sequence_rank
      is_straight = true
    end

    # same card count
    same_rank_array = []


    (0..rank_array.length - 1).each do |i|
      same_rank_array.push(rank_array.count(rank_array.uniq[i]))
      same_rank_array.delete(0)
    end

    same_rank_array = same_rank_array.sort

    case same_rank_array
    when [1,4]
      is_four_of_a_kind = true
    when [2,3]
      is_full_house = true
    when [1,1,3]
      is_three_of_a_kind = true
    when [1,2,2]
      is_two_pair = true
    when [1,1,1,2]
      is_one_pair = true
    end


    # 最終カード判定
    if is_straight_flush
      @check_result = 'Straight flush'
    elsif is_four_of_a_kind
      @check_result = 'Four of a kind'
    elsif is_full_house
      @check_result = 'Full house'
    elsif is_flush
      @check_result = 'Flush'
    elsif is_straight
      @check_result = 'Straight'
    elsif is_three_of_a_kind
      @check_result = 'Three of a kind'
    elsif is_two_pair
      @check_result = 'Two pair'
    elsif is_one_pair
      @check_result = 'One pair'
    else
      @check_result = ('High card')
    end
  end
end

