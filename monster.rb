#encoding:utf-8
module Irrgarten

  class Monster
    @@INITIAL_HEALTH = 5
    @@INVALID_POS = -1 # Indica que todavía no está situado en el laberinto

    def initialize(name, intelligence, strength)
      @name = name
      @intelligence = intelligence
      @strength = strength
      @row = @@INVALID_POS
      @col = @@INVALID_POS
      @health = @@INITIAL_HEALTH
    end

    def dead
      @health <= 0
    end

    def attack
      Dice.intensity(@strength)
    end

    def set_pos(row, col)
      @row = row
      @col = col
    end

    def to_s
      "Monster { Name: #{@name}, Intelligence: #{@intelligence}, " \
      "Strength: #{@strength}, Health: #{@health}, " \
      "Position: (#{@row}, #{@col}) }"
    end

    def got_wounded
      @health -= 1
    end

    def defend(received_attack)
      is_dead=dead
      if !is_dead
        defensive_energy=Dice.intensity(@intelligence)
        if defensive_energy<received_attack
          got_wounded
        end
        is_dead=dead
      end
      is_dead
    end

  end

end
