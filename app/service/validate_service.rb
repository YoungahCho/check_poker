module ValidateService

  def self.validate_cards(cards)
    errors, split_cards = errors_split_cards(cards)
    errors = empty_errors(errors, split_cards)
    errors = cards_errors(errors, split_cards)
    errors = duplicate_errors(errors, split_cards)
    errors = input_errors(errors, split_cards)
    errors = space_errors(errors, split_cards)
    errors(errors)
  end

  # @param cards [string] 5 cards include half-width space
  # @return errors [Array]
  # @return split_cards [Array] 5 cards include half-width space
  def self.errors_split_cards(cards)
    errors = []
    split_cards = cards.split(' ')
    [errors, split_cards]
  end

  # @return error messages if split_cards empty
  def self.empty_errors(errors, split_cards)
    errors << '入力されたカードがありません。' if split_cards.empty?
    errors
  end

  # @return error messages if split_cards are not 5
  def self.cards_errors(errors, split_cards)
    split_cards_count = split_cards.count
    if split_cards_count != 5
      errors << 'カードが5枚ではありません。'
      errors << '5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）'
    end
    errors
  end

  # @return error messages if split_cards include duplicated cards
  def self.duplicate_errors(errors, split_cards)
    if split_cards != split_cards.uniq
      duplicate_cards = split_cards.select { |c| split_cards.count(c) > 1 }.uniq
      errors << "カードが重複しています。(#{duplicate_cards})"
    end
    errors
  end

  # @return error messages if split_cards have incorrect card
  def self.input_errors(errors, split_cards)
    split_cards.each_with_index do |_item, i|
      if split_cards[i].match(/^[SDHC](1[0-3]|[1-9])$/)
        nil
      else
        errors << "#{i + 1}番目のカード指定文字が不正です。(#{split_cards[i]})"
      end
    end
    errors
  end

  # @return error messages if cards have full-width space
  def self.space_errors(errors, split_cards)
    split_cards.each_with_index do |_item, i|
      errors << "全角スペースが含まれています。(#{split_cards[i]})" if split_cards[i].include?('　')
    end
    errors
  end


  # @return error message if any error
  def self.errors(errors)
    errors << '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。' if errors.present?
    errors
  end

end



