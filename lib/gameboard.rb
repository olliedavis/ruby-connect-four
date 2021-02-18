class Gameboard
  attr_accessor :board

  def initialize
    @board = [
      row_six = [' |'] * 7,
      row_five = [' |'] * 7,
      row_four = [' |'] * 7,
      row_three = [' |'] * 7,
      row_two = [' |'] * 7,
      row_one = [' |'] * 7
    ]
  end



  def current_board
    puts 'Here is the current board:'
    board.each do |row|
      puts row.join
    end
  end

  def counter_drop(column, player)
    position = counter_drop_position(column)
    position[column] = player
  end

  def counter_drop_position(column)
    case ' |'
    when @board[0][column]
      @board[0]
    when @board[1][column]
      @board[1]
    when @board[2][column]
      @board[2]
    when @board[3][column]
      @board[3]
    when @board[4][column]
      @board[4]
    when @board[5][column]
      @board[5]
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
          break if winning_count?(correct_counter)
        else
          correct_counter = 0
        end
      end
      break if winning_count?(correct_counter)
    end
    winning_count?(correct_counter)
  end

  def won_diagonal?
    won_counter = 0
    @board.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        if ['X|', 'O|'].any?(col) && col == @board[row_idx + 1][col_idx + 1] && col == @board[row_idx + 2][col_idx + 2] && col == @board[row_idx + 3][col_idx + 3]
          won_counter += 1
        elsif ['X|', 'O|'].any?(col) && col == @board[row_idx + 1][col_idx - 1] && col == @board[row_idx + 2][col_idx - 2] && col == @board[row_idx + 3][col_idx - 3]
          won_counter += 1
        else
          next
        end
      end
    end
    won_counter >= 1
  end

  def winning_count?(counter)
    counter == 3
  end

  def won?
    true if won_straight_line? == true || won_diagonal? == true
  end
end
