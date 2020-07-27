class Deck
  DECK = {
    "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10,
    "V\u2666": 10, "V\u2663": 10, "V\u2660": 10, "V\u2665": 10, "D\u2666": 10,
    "D\u2663": 10, "D\u2660": 10, "D\u2665": 10, "K\u2666": 10, "K\u2663": 10,
    "K\u2660": 10, "K\u2665": 10, "A\u2666": 11, "A\u2663": 11, "A\u2660": 11,
    "A\u2665": 11
  }.freeze

  def initialize
    @current_deck = DECK.to_a
  end

  def take_card
    card = @current_deck.sample
    @current_deck.delete(card)
    card
  end

  def refresh_deck
    @current_deck = DECK.to_a
  end

  private

  attr_accessor :current_deck
end
