module Irrgarten

  class Labyrinth

    @@BLOCK_CHAR = 'X'
    @@EMPTY_CHAR = '-'
    @@MONSTER_CHAR = 'M'
    @@COMBAT_CHAR = 'C'
    @@EXIT_CHAR = 'E'

    @@ROW = 0
    @@COL = 1

    def initialize(n_rows, n_cols, exit_row, exit_col)
      @n_rows = n_rows
      @n_cols = n_cols
      @exit_row = exit_row
      @exit_col = exit_col

      @monsters = Array.new(@n_rows) {
        Array.new(@n_cols, nil)
      }

      @players = Array.new(@n_rows) {
        Array.new(@n_cols, nil)
      }

      @labyrinth = Array.new(@n_rows) {
        Array.new(@n_cols, @@EMPTY_CHAR)
      }

      @labyrinth[@exit_row][@exit_col] = @@EXIT_CHAR
    end

    # Se implementará en P3
    def spread_players(players)
      raise NotImplementedError
    end

    def have_a_winner
      @players[@exit_row][@exit_col] != nil
    end

    def to_s
      result = ""

      @labyrinth.each do |row|
        row.each do |cell|
          result += cell
        end

        result += "\n"
      end

      result
    end

    def add_monster(row, col, monster)
      if pos_ok(row, col) && empty_pos(row, col)
        @monsters[row][col] = monster
        @labyrinth[row][col] = @@MONSTER_CHAR
        monster.set_pos(row, col)
      end
    end

    # Se implementará en P3
    def put_player(direction, player)
      raise NotImplementedError
    end

    # Se implementará en P3
    def add_block(orientation, start_row, start_col, length)
      raise NotImplementedError
    end

    # Se implementará en P3
    def valid_moves(row, col)
      raise NotImplementedError
    end

    # Público en esta práctica por indicación de la profesora
    def random_empty_pos
      loop do
        random_row = Dice.random_pos(@n_rows)
        random_col = Dice.random_pos(@n_cols)

        if empty_pos(random_row, random_col)
          return [random_row, random_col]
        end
      end
    end

    private

    def pos_ok(row, col)
      row >= 0 && row < @n_rows &&
        col >= 0 && col < @n_cols
    end

    def empty_pos(row, col)
      @labyrinth[row][col] == @@EMPTY_CHAR
    end

    def monster_pos(row, col)
      @labyrinth[row][col] == @@MONSTER_CHAR
    end

    def exit_pos(row, col)
      @labyrinth[row][col] == @@EXIT_CHAR
    end

    def combat_pos(row, col)
      @labyrinth[row][col] == @@COMBAT_CHAR
    end

    def can_step_on(row, col)
      pos_ok(row, col) &&
        (empty_pos(row, col) ||
         monster_pos(row, col) ||
         exit_pos(row, col))
    end

    def update_old_pos(row, col)
      if pos_ok(row, col)
        if combat_pos(row, col)
          @labyrinth[row][col] = @@MONSTER_CHAR
        else
          @labyrinth[row][col] = @@EMPTY_CHAR
        end
      end
    end

    def dir2_pos(row, col, direction)
      new_row = row
      new_col = col

      case direction
      when Directions::UP
        new_row -= 1
      when Directions::DOWN
        new_row += 1
      when Directions::LEFT
        new_col -= 1
      when Directions::RIGHT
        new_col += 1
      end

      [new_row, new_col]
    end

    # Se implementará en P3
    def put_player_2d(old_row, old_col, row, col, player)
      raise NotImplementedError
    end

  end

end
