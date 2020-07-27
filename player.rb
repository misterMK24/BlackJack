class Player
  attr_reader :hand

  def initialize(name)
    @name = name
    @hand = {}
  end

  def add_card(card)
    raise 'You have a lot of cards' if @hand.size > 2

    @hand[card.first] = card.last
  end

  def show_cards
    @hand.each { |card| yield(card) }
  end

  def discard
    @hand.clear
  end

  private

  attr_accessor :name
  attr_writer :hand
end
