module BestService

def self.best_cards(hands)
  hands = ['Flush', 'Straight', 'Straight Flush']

  hands_hash = {}

  best = {
    'Straight Flush' => 9,
    'Four of a kind' => 8,
    'Full house' => 7,
    'Flush' => 6,
    'Straight' => 5,
    'Three of a kind' => 4,
    'Two pair' => 3,
    'One pair' => 2,
    'High card' => 1
  }



  end
end
