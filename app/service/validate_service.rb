module ValidateService

  def self.validate_cards(cards)
    errors = []

    # 全角スペースがあるか
    if cards.include?("　")
      space_error = true
      errors << "全角スペースが含まれています。"
    end

    # 入力カードがあるか
    if cards.blank?
      blank_error = true
      errors << "入力されたカードがありません。"
    end

    validate_cards_array = cards.split(" ")

    # カードが5枚入っているか
    if validate_cards_array.count < 5
      under_array_error = true
      errors << "カードが5枚以下です。"
    elsif validate_cards_array.count > 5
      over_array_error = true
      errors << "カードが5枚以上です。"
    end

    # カードのスートや数字に不正があるかどうか
    input_error = false
    (0..validate_cards_array.length - 1).each do |i|
      if validate_cards_array[i].match(/^[SDHC](1[0-3]|[1-9])$/)
        input_error = false
      else
        input_error = true
        errors << "#{i+1}番目のカード指定文字が不正です。(#{validate_cards_array[i]})"
      end
    end

    # 重複カードがあるか
    if validate_cards_array != validate_cards_array.uniq
      # overlap_card = validate_cards_array.inject(:&)
      overlap_error = true
      errors << "カードが重複しています。"
    end

    # 共通のエラーメッセージを追加する
    if space_error == true || blank_error == true || under_array_error == true || over_array_error == true
      errors << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    elsif input_error == true
      errors << "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    errors
  end

end
