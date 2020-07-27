require_relative 'player'

class Dealer < Player
  def initialize(name = 'Dealer')
    super
  end

  def add_card(card)
    @hand[card.first] = card.last if @hand.size < 3
  end
end
