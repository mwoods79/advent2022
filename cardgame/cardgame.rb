class Card
  attr_accessor :value, :suit

  def initialize(value, suit)
    self.value = value
    self.suit = suit
  end

  def read_card
    puts "#{value} of #{suit}."
  end
end

class Deck
  attr_accessor :deck

  def initialize
    self.deck = []
    values = %w[ace king queen jack ten nine eight seven six five four three
                two]
    suits = %w[clubs diamonds hearts spades]

    values.each do |value|
      suits.each do |suit|
        card = Card.new(value, suit)
        deck << card
      end
    end
  end

  def output_deck
    deck.each do |card|
      card.read_card
    end
  end
end

deck = Deck.new
deck.foo
