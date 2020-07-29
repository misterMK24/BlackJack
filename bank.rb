class Bank
  attr_accessor :player_bank, :dealer_bank

  def initialize
    @player_bank = INITIAL_BANK
    @dealer_bank = INITIAL_BANK
    @game_bank = 0
  end

  def increase_game_bank
    @game_bank += BET * 2
    @player_bank -= BET
    @dealer_bank -= BET
  end

  def transact_money(player)
    @player_bank += @game_bank if player.instance_of? Player
    @dealer_bank += @game_bank if player.instance_of? Dealer
    @game_bank = 0
  end

  def draw_result
    @player_bank += BET
    @dealer_bank += BET
    @game_bank = 0
  end

  private

  BET = 10
  INITIAL_BANK = 100

  attr_accessor :game_bank
end
