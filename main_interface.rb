module ExternalInterface

  def menu
    puts MENU[:main]
    case gets.chomp
    when '1' then start_game
    when '2' then exit
    end
  end

  private

  MENU = {
    main: [
      '1. Start game',
      '2. Quit game'
    ],
    game: [
      '1. Pass',
      '2. Take a card',
      '3. Show cards',
      '0. Exit'
    ]
  }.freeze

  def ask_name
    print 'Enter your name: '
  end

  def game_menu
    loop do
      end_game if hands_are_full?
      show_interface
      case gets.chomp
      when '1' then dealer_turn
      when '2' then take_one_card(@current_player)
      when '3' then end_game
      when '0' then exit
      end
    end
  end

  def show_interface
    show_player_hand
    print "\n Dealer's card: "
    puts '*' * @current_dealer.hand.size
    puts MENU[:game]
  end

  def warning_message
    puts 'Your hand is full!'
  end

  def show_dealer_hand
    print "Dealer's cards are: "
    @current_dealer.show_cards { |card| print "#{card.first} " }
    print "\n Dealer's score is: #{@dealer_score} \n"
  end

  def show_player_hand
    print 'Your cards are: '
    @current_player.show_cards { |card| print "#{card.first} " }
    print "\n Your score is: #{@player_score}"
  end

  def show_dealer_bank
    print "Dealer's bank is: #{@current_bank.dealer_bank} \n"
  end

  def show_player_bank
    print "Your bank is: #{@current_bank.player_bank} \n"
  end

  def winner_message
    if draw?
      puts 'Draw!'
    else
      case win?
      when true then puts 'Congrats, you have winning!'
      when false then puts 'You have lost!'
      end
    end
    puts 'Would you like to play again? (Yes/No)'
    again
  end

  def money_issue_message
    puts "Your bank is #{@current_bank.player_bank}"
    puts "You don't have enough money! End game"
  end
end
