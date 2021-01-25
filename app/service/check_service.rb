module CheckService
  include HandService

  def self.check_cards(cards)
    suits, numbers = split_cards(cards)
    poker_hand(is_all_same_suits?(suits), is_sequence_numbers?(numbers), same_numbers(numbers))
  end

  # @param cards [string] 5 cards include half-width space
  # @return suits [Array<String>] 5 alphabets from 5 cards
  # @return numbers [Array<Integer>] 5 numbers from 5 cards
  def self.split_cards(cards)
    split_cards = cards.split(' ')
    suits = split_cards.map { |c| c[0] }
    numbers = split_cards.map { |c| c[1..2].to_i }.sort!
    [suits, numbers]
  end

  # @param suits [Array<String>] 5 alphabets from 5 cards
  # @return [Boolean] true if cards have a one suit
  def self.is_all_same_suits?(suits)
    suits.uniq.length == 1
  end

  # @param numbers [Array<Integer>] 5 numbers from 5 cards
  # @return [Boolean] true if cards have sequence numbers
  def self.is_sequence_numbers?(numbers)
    result = true
    numbers.each_cons(2) do |nums|
      if nums[0] + 1 != nums[1]
        result = false
        break
      else
        result = true
      end
    end
    result
  end

  # @param numbers [Array<Integer>] 5 numbers from 5 cards
  # @return same_numbers [Array<Integer>] number of times duplicate elements were deleted
  def self.same_numbers(numbers)
    uniq_numbers = numbers.uniq
    same_numbers = uniq_numbers.map { |n| numbers.count(n) }
    same_numbers.sort!
  end

  # @param _is_all_same_suits [Boolean], _is_sequence_numbers [Boolean], same_numbers [Array]
  # @return @check_result hand name as result of checking suits and numbers
  # @see HandService
  def self.poker_hand(_is_all_same_suits, _is_sequence_numbers, same_numbers)
    @check_result = if _is_all_same_suits && _is_sequence_numbers
                      STRAIGHT_FLUSH
                    elsif same_numbers == [1, 4]
                      FOUR_OF_A_KIND
                    elsif same_numbers == [2, 3]
                      FULL_HOUSE
                    elsif _is_all_same_suits
                      FLUSH
                    elsif _is_sequence_numbers
                      STRAIGHT
                    elsif same_numbers == [1, 1, 3]
                      THREE_OF_A_KIND
                    elsif same_numbers == [1, 2, 2]
                      TWO_PAIR
                    elsif same_numbers == [1, 1, 1, 2]
                      ONE_PAIR
                    else
                      HIGH_CARD
                    end
  end
end

