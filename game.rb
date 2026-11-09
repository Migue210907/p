module Irrgarten

  class Game

    @@MAX_ROUNDS = 10

    def initialize(n_players, debug=false)
      @players = []
      @monsters = []

      n_players.times do |i|
        @players << Player.new(i.to_s, Dice.random_intelligence, Dice.random_strength)
      end

      @current_player_index = Dice.who_starts(n_players)
      @current_player = @players[@current_player_index]

      @log = ""

      @labyrinth = Labyrinth.new(5, 5, 4, 4)

      if debug
        configure_labyrinth_debug
      else
        configure_labyrinth
      end
      
      @labyrinth.spread_players(@players)
    end


    def finished
      @labyrinth.have_a_winner
    end


    def next_step(preferred_direction)
      @log=""
      dead=@current_player.dead
      if !dead
        direction=actual_direction(preferred_direction);
        if direction != preferred_direction
          log_player_no_orders
        end
        monster=@labyrinth.put_player(direction, @current_player)
        if monster==nil
          log_no_monster
        else
          winner=combat(monster)
          manage_reward(winner)
        end
      else
        manage_resurrection
      end
      end_game=finished
      if !end_game
        next_player
      end
      end_game
    end


    def get_game_state
      GameState.new(
        @labyrinth.to_s,
        @players.to_s,
        @monsters.to_s,
        @current_player_index,
        finished,
        @log
      )
    end


    private


    def configure_labyrinth
      @labyrinth.add_block(
        Orientation::VERTICAL,
        1,
        1,
        2
      )

      @labyrinth.add_block(
        Orientation::HORIZONTAL,
        3,
        2,
        2
      )

      n_monsters = 2

      n_monsters.times do |i|
        monster = Monster.new(
          "Monster ##{i}",
          Dice.random_intelligence,
          Dice.random_strength
        )

        @monsters << monster

        pos = @labyrinth.random_empty_pos

        @labyrinth.add_monster(
          pos[0],
          pos[1],
          monster
        )
      end
    end

    def configure_labyrinth_debug
      @labyrinth.add_block(Orientation::VERTICAL, 1, 1, 2)
      
      monster = Monster.new("Monster #Debug", Dice.random_intelligence, Dice.random_strength)
      @monsters << monster
      
      @labyrinth.add_monster(1, 0, monster)
    end


    def next_player
      @current_player_index =
        (@current_player_index + 1) % @players.size

      @current_player =
        @players[@current_player_index]
    end


    def actual_direction(preferred_direction)
      current_row=@current_player.row
      current_col=@current_player.col
      valid_moves=@labyrinth.valid_moves(current_row, current_col)
      output=@current_player.move(preferred_direction, valid_moves)
      output
    end


    def combat(monster)
      rounds=0
      winner=GameCharacter::PLAYER
      player_attack=@current_player.attack
      lose=monster.defend(player_attack)
      while (!lose) && (rounds<@@MAX_ROUNDS)
        winner=GameCharacter::MONSTER
        rounds += 1
        monster_attack=monster.attack
        lose=@current_player.defend(monster_attack)
        if !lose
          player_attack=@current_player.attack
          winner=GameCharacter::PLAYER
          lose=monster.defend(player_attack)
        end
      end
      log_rounds(rounds, @@MAX_ROUNDS)
      winner
    end


    def manage_reward(winner)
      if winner==GameCharacter::PLAYER
        @current_player.receive_reward
        log_player_won
      else
        log_monster_won
      end
    end


    def manage_resurrection
      resurrect=Dice.resurrect_player
      if resurrect
        @current_player.resurrect
        log_resurrected
      else
        log_player_skip_turn
      end
    end


    def log_player_won
      @log += "El jugador ha ganado el combate.\n"
    end


    def log_monster_won
      @log += "El monstruo ha ganado el combate.\n"
    end


    def log_resurrected
      @log += "El jugador ha resucitado.\n"
    end


    def log_player_skip_turn
      @log += "El jugador ha perdido el turno por estar muerto.\n"
    end


    def log_player_no_orders
      @log += "El jugador no ha seguido las instrucciones del jugador humano (no fue posible).\n"
    end


    def log_no_monster
      @log += "El jugador se ha movido a una celda vacía o no le ha sido posible moverse.\n"
    end


    def log_rounds(rounds, max)
      @log += "Se han producido #{rounds} de #{max} rondas de combate.\n"
    end

  end

end