require_relative 'player'
require_relative 'dealer'
require_relative 'bank'
require_relative 'deck'
require_relative 'internal_interface'
require_relative 'interface'
require_relative 'game'

game = Game.new
Interface.menu(game)
