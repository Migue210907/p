#encoding:utf-8

require_relative '../dice'
require_relative '../directions'
require_relative '../orientation'
require_relative '../game_character'
require_relative '../weapon'
require_relative '../shield'
require_relative '../game_state'
require_relative '../monster'
require_relative '../player'
require_relative '../labyrinth'
require_relative '../game'


game = Irrgarten::Game.new(2, true)


puts "===== ESTADO INICIAL ====="
state = game.get_game_state
puts state.labyrinth
puts state.players
puts state.monsters
# Fuerza el combate
game.next_step(
  Irrgarten::Directions::DOWN
)

puts "===== DESPUES DE DOWN ====="
state = game.get_game_state
puts state.labyrinth
puts state.players
puts state.monsters
puts state.log