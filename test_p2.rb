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

      # =========================
      # MONSTER
      # =========================

      puts "===== MONSTER ====="

      monster = Monster.new(
        "Monstruo 1",
        5.0,
        7.0
      )

      puts monster
      puts "Muerto: #{monster.dead}"
      puts "Ataque: #{monster.attack}"

      monster.set_pos(2, 3)

      puts "Después de set_pos:"
      puts monster

      monster.got_wounded

      puts "Después de recibir daño:"
      puts monster


      # =========================
      # PLAYER
      # =========================

      puts
      puts "===== PLAYER ====="

      player = Player.new(
        "1",
        6.0,
        8.0
      )

      puts player

      puts "Número: #{player.number}"
      puts "Fila: #{player.row}"
      puts "Columna: #{player.col}"

      player.set_pos(1, 2)

      puts "Después de set_pos:"
      puts player

      puts "Muerto: #{player.dead}"
      puts "Ataque: #{player.attack}"

      player.resurrect

      puts "Después de resurrect:"
      puts player


      # =========================
      # LABYRINTH
      # =========================

      puts
      puts "===== LABYRINTH ====="

      labyrinth = Labyrinth.new(
        5,
        5,
        4,
        4
      )

      puts "Laberinto inicial:"
      puts labyrinth

      puts "¿Hay ganador?: #{labyrinth.have_a_winner}"


      # =========================
      # RANDOM EMPTY POS
      # =========================

      pos = labyrinth.random_empty_pos

      puts "Posición vacía aleatoria:"
      puts "(#{pos[0]}, #{pos[1]})"


      # =========================
      # AÑADIR MONSTRUO
      # =========================

      monster2 = Monster.new(
        "Monstruo 2",
        4.0,
        5.0
      )

      labyrinth.add_monster(
        pos[0],
        pos[1],
        monster2
      )

      puts "Después de añadir monstruo:"
      puts labyrinth

      puts "Estado del monstruo añadido:"
      puts monster2

    end

  end

end


Irrgarten::TestP2.main