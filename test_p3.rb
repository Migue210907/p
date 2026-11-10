#encoding:utf-8

require_relative 'dice'
require_relative 'directions'
require_relative 'orientation'
require_relative 'game_character'
require_relative 'weapon'
require_relative 'shield'
require_relative 'game_state'
require_relative 'monster'
require_relative 'player'
require_relative 'labyrinth'
require_relative 'game'

module Irrgarten

  class TestP3

    def self.main

      puts "=== MOVE ==="
      player = Player.new("0",5.0,6.0)
      moves = [Directions::DOWN,Directions::RIGHT]
      puts player.move(Directions::UP,moves)

      puts "\n=== MONSTER DEFEND ==="
      monster = Monster.new("Monster",1.0,2.0)
      puts monster
      monster.defend(1000.0)
      puts monster

      puts "\n=== REWARD ==="
      puts player
      player.receive_reward
      puts player

      puts "\n=== LABYRINTH ==="
      labyrinth = Labyrinth.new(5,5,4,4)
      players = [player]
      labyrinth.spread_players(players)
      puts labyrinth
      puts labyrinth.valid_moves(player.row,player.col)


      puts "\n=== GAME ==="
      game = Game.new(2)
      puts game.get_game_state.labyrinth
      game.next_step(Directions::DOWN)
      puts game.get_game_state.labyrinth
      puts game.get_game_state.log

    end

  end

end

Irrgarten::TestP3.main