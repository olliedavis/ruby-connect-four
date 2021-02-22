class Gameboard
  attr_accessor :board

  def initialize
    @board = [
      [' |'] * 7,
      [' |'] * 7,
      [' |'] * 7,
      [' |'] * 7,
      [' |'] * 7,
      [' |'] * 7
    ]
    @tokens = ['X|', 'O|']
  end

  def current_board
    board.each do |row|
      puts row.join
    end
    puts '1|2|3|4|5|6|7'
  end

  def counter_drop(column, player)
    position = counter_drop_position(column)
    position[column] = player
  end

  def counter_drop_position(column)
    case ' |'
    when @board[5][column]
      @board[5]
    when @board[4][column]
      @board[4]
    when @board[3][column]
      @board[3]
    when @board[2][column]
      @board[2]
    when @board[1][column]
      @board[1]
    when @board[0][column]
      @board[0]
    end
  end

  def full_board?
    full_row = 0
    @board.each do |row|
      full_row += 1 if row.include?(' |') == false
    end
    full_row == 6
  end

  def won_horizontal?
    win_counter = 0
    @board.reverse.each do |row|
      row.each_with_index do |col, idx|
        if @tokens.any?(col) && col == row[idx + 1]
          win_counter += 1
          return true if win_counter >= 3
        else
          win_counter = 0
        end
      end
    end
    false
  end

  def won_diagonal?
    @board.reverse.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        begin
          if @tokens.any?(col) && [
            @board.reverse[row_idx + 1][col_idx + 1],
            @board.reverse[row_idx + 2][col_idx + 2],
            @board.reverse[row_idx + 3][col_idx + 3]
          ].all? { |token| token == col }
            return true
          # reverse diagonal
          elsif @tokens.any?(col) && [
            @board.reverse[row_idx + 1][col_idx - 1],
            @board.reverse[row_idx + 2][col_idx - 2],
            @board.reverse[row_idx + 3][col_idx - 3]
          ].all? { |token| token == col }
            return true
          end
        rescue StandardError # returns false when starting row_idx is past the middle row of the board array
          return false
        end
      end
    end
    false
  end

  def won_vertical?
    @board.reverse.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        begin
          if col != ' |' && [
            @board.reverse[row_idx][col_idx],
            @board.reverse[row_idx + 1][col_idx],
            @board.reverse[row_idx + 2][col_idx],
            @board.reverse[row_idx + 3][col_idx]
          ].all? { |token| token == col }
            return true
          end
        rescue StandardError # returns false when starting row_idx is past the middle row of the board array
          return false
        end
      end
    end
    false
  end
end
