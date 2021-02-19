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

  def won_straight_line?
    correct_counter = 0
    @board.each do |row|
      row.each_with_index do |col, idx|
        if col == 'X|' || col == 'O|' && col == col[idx + 1]
          correct_counter += 1
          break if correct_counter > 3
        else
          correct_counter = 0
        end
      end
      break if correct_counter > 3
    end
    correct_counter > 3
  end

  def won_diagonal?(current_player)
    won_counter = 0
    @board[0..2].reverse.each_with_index do |row, row_idx|
      row[0..3].each_with_index do |_col, col_idx|
        if current_player == @board[row_idx][col_idx] && current_player == @board[row_idx + 1][col_idx + 1] && current_player == @board[row_idx + 2][col_idx + 2] && current_player == @board[row_idx + 3][col_idx + 3]
          won_counter += 1
        else
          next
        end
      end
      row[3..6].each_with_index do |_col, col_idx|
        if current_player == @board[row_idx][col_idx] && current_player == @board[row_idx + 1][col_idx - 1] && current_player == @board[row_idx + 2][col_idx - 2] && current_player == @board[row_idx + 3][col_idx - 3]
          won_counter += 1
        else
          next
        end
      end
    end
    won_counter >= 1
  end

  def won?
    true if won_straight_line? == true || won_diagonal? == true
  end
end
