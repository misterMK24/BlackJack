module InternalInterface

  attr_reader :current_player, :current_dealer, :current_deck, :player_score, :dealer_score

  def first_turn
    @current_bank.increase_game_bank
    give_cards
    calculate_score
    Interface.game_menu(self)
  end

  def dealer_turn
    take_one_card(@current_dealer) if @dealer_score < DEALER_MAX
  end

  def take_one_card(player)
    player.add_card(@current_deck.take_card)
    ace_decide(player) if ace?(player.hand.values.last)
    calculate_score
  rescue RuntimeError
    Interface.warning_message
  end

  def hands_are_full?
    @current_player.hand.size == 3 && @current_dealer.hand.size == 3
  end

  def draw?
    @player_score == @dealer_score
  end

  def win?
    case [@player_score, @dealer_score].sort.reverse.bsearch { |value| value <= BJ_VALUE }
    when @player_score then true
    when @dealer_score then false
    end
  end

  def enough_money?
    case @current_bank.player_bank
    when 0 then false
    else true
    end
  end

  def end_game
    Interface.show_player_hand(@current_player, @player_score)
    Interface.show_dealer_hand(@current_dealer, @dealer_score)
    clear_cache
    Interface.show_dealer_bank(@current_bank)
    Interface.show_player_bank(@current_bank)
    Interface.winner_message(self)
  end

  private

  attr_accessor :players
  attr_writer :current_player, :current_dealer, :current_deck, :player_score, :dealer_score

  BJ_VALUE = 21
  ACE_11 = 11
  ACE_1 = 1
  DEALER_MAX = 17

  def winner
    return nil if draw?

    case win?
    when true then @current_player
    else @current_dealer
    end
  end

  def ace_decide(player)
    current_score = player.hand.values.sum
    possible_score = current_score - 10
    case [current_score, possible_score].sort.reverse.bsearch { |value| value <= BJ_VALUE }
    when possible_score then player.hand[player.hand.keys.last] = ACE_1
    end
  end

  def ace?(value)
    value == ACE_11
  end

  def calculate_score
    @player_score = @current_player.hand.values.sum
    @dealer_score = @current_dealer.hand.values.sum
  end

  def give_cards
    @players.each do |player|
      2.times { take_one_card(player) }
    end
  end

  def clear_cache
    @current_bank.transact_money(winner) if winner
    @current_bank.draw_result if draw?
    @current_player.discard
    @current_dealer.discard
    @current_deck.refresh_deck
  end

end
