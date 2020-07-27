require_relative 'player'
require_relative 'dealer'
require_relative 'bank'
require_relative 'deck'
require_relative 'internal_interface'
require_relative 'main_interface'

class Game
  include InternalInterface
  include ExternalInterface
end

game = Game.new
game.menu
