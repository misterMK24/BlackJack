class Bank
  attr_accessor :player_bank, :dealer_bank

  def initialize
    @player_bank = 100
    @dealer_bank = 100
    @game_bank = 0
  end

  def increase_game_bank
    @game_bank += 20
    @player_bank -= 10
    @dealer_bank -= 10
  end

  def transact_money(player)
    @player_bank += @game_bank if player.instance_of? Player
    @dealer_bank += @game_bank if player.instance_of? Dealer
    @game_bank = 0
  end

  def draw_result
    @player_bank += 10
    @dealer_bank += 10
    @game_bank = 0
  end

  private

  attr_accessor :game_bank
end
