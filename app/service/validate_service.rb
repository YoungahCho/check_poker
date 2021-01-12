module ValidateService

  def self.validate_cards(cards)
    errors = []

    # 半角スペースを基準に配列に要素を入れる
    validate_cards_array = cards.split(' ')

    # カードが5枚入っているか
    if validate_cards_array.count < 5
      under_array_error = true
      errors << 'カードが5枚未満です。'
    elsif validate_cards_array.count > 5
      over_array_error = true
      errors << 'カードが5枚超過です。'
    end

    # カードのスートや数字に不正があるか
    input_error_array = []
    (0..validate_cards_array.length - 1).each do |i|
      if validate_cards_array[i].match(/^[SDHC](1[0-3]|[1-9])$/)
        input_error = false
        input_error_array << input_error
      else
        input_error = true
        input_error_array << input_error
        errors << "#{i + 1}番目のカード指定文字が不正です。(#{validate_cards_array[i]})"
      end
    end

    # 一つの要素でも不正のスートや数字が入っているとinput errorを返す
    input_error = if input_error_array.include? true
                    true
                  else
                    false
                  end

    # 全角スペースが入っているか
    (0..validate_cards_array.length - 1).each do |i|
      if validate_cards_array[i].include?('　')
        errors.clear
        errors << "全角スペースが含まれています。(#{validate_cards_array[i]})"
      end
    end

    # 重複カードがあるか
    if validate_cards_array != validate_cards_array.uniq
      overlap_card = validate_cards_array.group_by { |i| i }.reject { |k, v| v.one? }.keys
      errors << "カードが重複しています。(#{overlap_card})"
    end

    # 何も入ってない
    if validate_cards_array.empty?
      errors.clear
      errors << '入力されたカードがありません。'
    end

    # 共通のエラーメッセージを追加する
    if under_array_error == true || over_array_error == true
      errors << '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
    end

    errors << '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' if input_error == true
    errors
    end
  end


