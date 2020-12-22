module ValidateService

  def self.validate_cards(cards)

    validate_cards_array = cards.split(" ")
    # 半角スペースを基準でparamsを分けて配列に入れる

    if validate_cards_array.count != 5
      array_error = true
    elsif validate_cards_array.blank?
      blank_error = true
    end

    errors = []
    # = erros_array = Array.new
    (0..validate_cards_array.length-1).each do |i|
      if validate_cards_array[i].match(/^[SDHC](1[0-3]|[1-9])$/)
        false
      else
        input_error = true
        errors << "#{i+1}番目のカード指定文字が不正です。(#{validate_cards_array[i]})"
      end
    end

    if array_error == true || blank_error == true
      errors.clear
      errors << "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    elsif errors.present?
      input_error = true
      errors << "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end

    errors
  end

end
