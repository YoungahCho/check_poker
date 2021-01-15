module ValidateService

  def self.validate_cards(cards)
    errors = []

    # 半角スペースを基準に配列に要素を入れる
    validate_cards = cards.split(' ')

    # カードが5枚入っているか
    validate_cards_count = validate_cards.count
    if validate_cards_count < 5
      under_array_error = true
      errors << 'カードが5枚未満です。'
    elsif validate_cards_count > 5
      over_array_error = true
      errors << 'カードが5枚超過です。'
    end

    # カードのスートや数字に不正があるか
    input_error = []
    validate_cards.each_with_index do |_item, i|
      if validate_cards[i].match(/^[SDHC](1[0-3]|[1-9])$/)
        input_error << false
      else
        input_error << true
        errors << "#{i + 1}番目のカード指定文字が不正です。(#{validate_cards[i]})"
      end

      # 全角スペースが入っているか
      errors << "全角スペースが含まれています。(#{validate_cards[i]})" if validate_cards[i].include?('　')
    end

    # 重複カードがあるか
    if validate_cards != validate_cards.uniq
      overlap_cards = validate_cards.group_by { |i| i }.reject { |_k, v| v.one? }.keys
      errors << "カードが重複しています。(#{overlap_cards})"
    end

    # 何も入ってない
    if validate_cards.empty?
      errors.clear
      errors << '入力されたカードがありません。'
    end

    # 共通のエラーメッセージを追加する
    if under_array_error == true || over_array_error == true
      errors << '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
    end

    # 一つの要素でも不正のスートや数字が入っているとinput errorを返す
    errors << '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' if input_error.include? (true)
    errors
  end
end
