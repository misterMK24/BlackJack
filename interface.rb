module Interface
  module_function

  def menu(game)
    puts MENU[:main]
    case gets.chomp
    when '1' then game.first_turn
    when '2' then exit
    end
  end

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
    ],
    full_hand_menu: [
      '3. Show cards'
    ]
  }.freeze

  def ask_name
    print 'Enter your name: '
  end

  def game_menu(game)
    loop do
      game.end_game if game.hands_are_full?
      show_interface(game)
      case gets.chomp
      when '1' then game.dealer_turn
      when '2'
        game.take_one_card(game.current_player)
        game.dealer_turn
      when '3' then game.end_game
      when '0' then exit
      end
    end
  end

  def show_interface(game)
    show_player_hand(game.current_player, game.player_score)
    print "\n Dealer's card: "
    puts '*' * game.current_dealer.hand.size
    case game.current_player.hand.size
    when 1..2 then puts MENU[:game]
    when 3 then puts MENU[:full_hand_menu]
    end
  end

  def warning_message
    puts 'Your hand is full!'
  end

  def show_dealer_hand(dealer, score)
    print "Dealer's cards are: "
    dealer.show_cards { |card| print "#{card.first} " }
    print "\n Dealer's score is: #{score} \n"
  end

  def show_player_hand(player, score)
    print 'Your cards are: '
    player.show_cards { |card| print "#{card.first} " }
    print "\n Your score is: #{score} \n"
  end

  def show_dealer_bank(bank)
    print "Dealer's bank is: #{bank.dealer_bank} \n"
  end

  def show_player_bank(bank)
    print "Your bank is: #{bank.player_bank} \n"
  end

  def winner_message(game)
    if game.draw?
      puts 'Draw!'
    else
      case game.win?
      when true then puts 'Congrats, you have winning!'
      when false then puts 'You have lost!'
      end
    end
    puts 'Would you like to play again? (Yes/No)'
    again(game)
  end

  def money_issue_message(bank)
    puts "Your bank is #{bank.player_bank}"
    puts "You don't have enough money! End game"
    exit
  end

  def again(game)
    loop do
      case gets.chomp.downcase
      when 'yes'
        game.enough_money? ? game.first_turn : money_issue_message(game.current_bank)
      when 'no' then exit
      end
    end
  end
end
