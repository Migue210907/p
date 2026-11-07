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

      puts "===== ENUMERADOS ====="

      puts Directions::LEFT
      puts Orientation::VERTICAL
      puts GameCharacter::PLAYER


      puts "\n===== WEAPON ====="

      weapon1 = Weapon.new(2.0, 5)
      weapon2 = Weapon.new(3.0, 2)

      puts weapon1
      puts weapon2

      puts "Ataque: #{weapon1.attack}"
      puts "Después: #{weapon1}"

      puts "Descartar: #{weapon1.discard}"


      puts "\n===== SHIELD ====="

      shield1 = Shield.new(3.0, 4)
      shield2 = Shield.new(2.0, 2)

      puts shield1
      puts shield2

      puts "Protección: #{shield1.protect}"
      puts "Después: #{shield1}"

      puts "Descartar: #{shield1.discard}"


      puts "\n===== GAME STATE ====="

      state1 = GameState.new(
        "Laberinto 1",
        "Jugadores 1",
        "Monstruos 1",
        0,
        false,
        "Comienza la partida"
      )

      state2 = GameState.new(
        "Laberinto 2",
        "Jugadores 2",
        "Monstruos 2",
        1,
        true,
        "Fin de partida"
      )

      puts state1.labyrinth
      puts state1.players
      puts state1.monsters
      puts state1.current_player
      puts state1.winner
      puts state1.log

      puts state2.labyrinth


      puts "\n===== DICE - 100 PRUEBAS ====="

      resurrections = 0
      discarded = 0

      intelligence_sum = 0.0
      strength_sum = 0.0


      100.times do

        random_pos = Dice.random_pos(10)
        starts = Dice.who_starts(4)

        intelligence = Dice.random_intelligence
        strength = Dice.random_strength

        resurrect = Dice.resurrect_player

        weapons = Dice.weapons_reward
        shields = Dice.shields_reward
        health = Dice.health_reward

        weapon_power = Dice.weapon_power
        shield_power = Dice.shield_power

        uses = Dice.uses_left

        intensity = Dice.intensity(5.0)

        discard = Dice.discard_element(uses)


        intelligence_sum += intelligence
        strength_sum += strength

        if resurrect
          resurrections += 1
        end

        if discard
          discarded += 1
        end
      end


      puts "Resurrecciones: #{resurrections} de 100"
      puts "Elementos descartados: #{discarded} de 100"

      puts "Inteligencia media: #{intelligence_sum / 100}"
      puts "Fuerza media: #{strength_sum / 100}"

    end

  end

end


Irrgarten::TestP1.main