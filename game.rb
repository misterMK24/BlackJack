class Game
  include InternalInterface

  def initialize
    Interface.ask_name
    @current_player = Player.new(gets.chomp)
    @current_dealer = Dealer.new
    @current_deck = Deck.new
    @current_bank = Bank.new
    @players = [@current_player, @current_dealer]
  end
end
