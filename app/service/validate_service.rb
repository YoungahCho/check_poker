module ValidateService

  def self.validate_cards(cards)
    errors = []
    split_cards = cards.split(' ')

    errors << '入力されたカードがありません。' if split_cards.empty?
    errors << 'カードが5枚ではありません。' if split_cards.count != 5

    full_width_cards = split_cards.map { |c| c if c.include?('　') }.compact
    errors << '全角スペースが含まれています。' if full_width_cards.present?

    if split_cards.empty? || full_width_cards.present? || split_cards.count != 5
      errors << '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
      return errors
    end

    if errors.empty?
      errors << duplicate_errors(split_cards)
      # errors << input_errors(split_cards)
      errors(errors)
    end
  end

  # @return error messages if split_cards include duplicated cards
  def self.duplicate_errors(split_cards)
      # duplicate_cards = split_cards.select { |c| split_cards.count(c) > 1 }.uniq
    'カードが重複しています。' if split_cards != split_cards.uniq
    p split_cards
    p split_cards.uniq
  end

  # @return error messages if split_cards have incorrect card
  def self.input_errors(split_cards)
    split_cards.each_with_index do |_item, i|
      if split_cards[i].match(/^[SDHC](1[0-3]|[1-9])$/)
        nil
      else
        "#{i + 1}番目のカード指定文字が不正です。(#{split_cards[i]})"
        return
      end
    end
  end

  # @return error message if any error
  def self.errors(errors)
    errors << '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' if errors.present?
    errors
  end

end



