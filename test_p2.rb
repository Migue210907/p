#encoding:utf-8

require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'
require_relative 'directions'
require_relative 'orientation'
require_relative 'monster'
require_relative 'player'
require_relative 'labyrinth'

module Irrgarten

  class TestP2

    def self.main

      puts "=== MONSTER ==="
      monster = Monster.new("Monster",5.0,7.0)
      puts monster
      monster.set_pos(2, 2)
      puts monster
      puts monster.attack

      puts "\n=== PLAYER ==="
      player = Player.new("0",6.0,8.0)
      puts player
      player.set_pos(1, 1)
      puts player
      puts player.attack

      puts "\n=== LABYRINTH ==="
      labyrinth = Labyrinth.new(5,5,4,4)
      puts labyrinth
      labyrinth.add_monster(2,2,monster)
      puts labyrinth
      puts labyrinth.have_a_winner

    end

  end

end

Irrgarten::TestP2.main