#encoding:utf-8

require_relative 'directions'
require_relative 'orientation'
require_relative 'game_character'
require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'
require_relative 'game_state'

module Irrgarten

  class TestP1

    def self.main

      puts "=== ENUMERADOS ==="
      puts Directions::LEFT
      puts Orientation::VERTICAL
      puts GameCharacter::PLAYER


      puts "\n=== WEAPON ==="
      weapon = Weapon.new(2.0, 3)
      puts weapon
      puts weapon.attack
      puts weapon

      puts "\n=== SHIELD ==="
      shield = Shield.new(2.0, 3)
      puts shield
      puts shield.protect
      puts shield

      puts "\n=== GAME STATE ==="
      state = GameState.new("laberinto","jugadores","monstruos",0,false,"log")
      puts state.labyrinth
      puts state.players
      puts state.monsters

      puts "\n=== DICE ==="
      puts Dice.random_pos(5)
      puts Dice.random_intelligence
      puts Dice.random_strength

      puts "\n=== DISCARD ==="
      (0..5).each do |uses|
        discarded = 0
        not_discarded = 0
        
        100.times do
          if Dice.discard_element(uses)
            discarded += 1
          else
            not_discarded += 1
          end
        end

        puts "Usos #{uses}: true=#{discarded}, false=#{not_discarded}"
      end
    end

  end

end

Irrgarten::TestP1.main