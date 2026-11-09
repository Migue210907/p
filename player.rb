module Irrgarten

  class Player

    @@MAX_WEAPONS = 2
    @@MAX_SHIELDS = 3
    @@INITIAL_HEALTH = 10
    @@HITS2LOSE = 3

    # Consultores públicos que aparecen en el diagrama
    attr_reader :row, :col, :number

    def initialize(number, intelligence, strength)
      @number = number
      @name = "Player ##{number}"
      @intelligence = intelligence
      @strength = strength

      @health = @@INITIAL_HEALTH
      @row = 0
      @col = 0
      @consecutive_hits = 0

      @weapons = []
      @shields = []
    end

    def resurrect
      @weapons = []
      @shields = []
      @health = @@INITIAL_HEALTH
      @consecutive_hits = 0
    end

    def set_pos(row, col)
      @row = row
      @col = col
    end

    def dead
      @health <= 0
    end

    def move(direction, valid_moves)
      size=valid_moves.size
      contained=valid_moves.include?(direction)
      if (size>0) && (!contained)
        first_element=valid_moves[0]
        first_element
      else
        direction
      end
    end

    def attack
      @strength + sum_weapons
    end

    def defend(received_attack)
      manage_hit(received_attack)
    end

    def receive_reward
      w_reward=Dice.weapons_reward
      s_reward=Dice.shields_reward

      i=1
      while i <= w_reward
        wnew=new_weapon
        receive_weapon(wnew)
        i+=1
      end

      j=1
      while j <= s_reward
        snew=new_shield
        receive_shield(snew)
        j+=1
      end

      extra_health=Dice.health_reward

      @health+=extra_health

    end

    def to_s
      "Player { Name: #{@name}, Number: #{@number}, " \
      "Intelligence: #{@intelligence}, Strength: #{@strength}, " \
      "Health: #{@health}, Position: (#{@row}, #{@col}), " \
      "Consecutive hits: #{@consecutive_hits}, " \
      "Weapons: #{@weapons}, Shields: #{@shields} }"
    end


    private

    def receive_weapon(w)
      @weapons.delete_if do |weapon|
        weapon.discard
      end

      if @weapons.size < @@MAX_WEAPONS
        @weapons << w
      end
    end

    def receive_shield(s)
      @shields.delete_if do |shield|
        shield.discard
      end

      if @shields.size < @@MAX_SHIELDS
        @shields << s
      end
    end

    def new_weapon
      Weapon.new(Dice.weapon_power, Dice.uses_left)
    end

    def new_shield
      Shield.new(Dice.shield_power, Dice.uses_left)
    end

    def sum_weapons
      sum = 0

      @weapons.each do |weapon|
        sum += weapon.attack
      end

      sum
    end

    def sum_shields
      sum = 0

      @shields.each do |shield|
        sum += shield.protect
      end

      sum
    end

    def defensive_energy
      @intelligence + sum_shields
    end

    def manage_hit(received_attack)
      defense=defensive_energy

      if defense<received_attack
        got_wounded
        inc_consecutive_hits
      else
        reset_hits
      end

      if @consecutive_hits==@@HITS2LOSE || dead
        reset_hits
        lose=true
      else
        lose=false
      end

      lose
    end

    def reset_hits
      @consecutive_hits = 0
    end

    def got_wounded
      @health -= 1
    end

    def inc_consecutive_hits
      @consecutive_hits += 1
    end

  end

end