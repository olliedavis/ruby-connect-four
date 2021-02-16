class Gameboard
  def initialize
    @board = [
      row_one = [' |'] * 7,
      row_two = [' |'] * 7,
      row_three = [' |'] * 7,
      row_four = [' |'] * 7,
      row_five = [' |'] * 7,
      row_six = [' |'] * 7
    ]
  end

  def board
    
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
    when @row_six[column]
      @row_six
    when @row_five[column]
      @row_five
    when @row_four[column]
      @row_four
    when row_three[column]
      @row_three
    when @row_two[column]
      @row_two
    when @row_one[column]
      @row_one
    end
  end

  def full_board?
    full_row = 0
    board.each do |row|
      full_row += 1 if row.include?(' |') == false
    end
    true if full_row == 6
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
    @board.reverse.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        if ['X|', 'O|'].any?(col) && col == @board.reverse[row_idx + 1][col_idx + 1] && col == @board.reverse[row_idx + 2][col_idx + 2] && col == @board.reverse[row_idx + 3][col_idx + 3]
          won_counter += 1
        elsif ['X|', 'O|'].any?(col) && col == @board.reverse[row_idx + 1][col_idx - 1] && col == @board.reverse[row_idx + 2][col_idx - 2] && col == @board.reverse[row_idx + 3][col_idx - 3]
          won_counter += 1
        else
          next
        end
      end
    end
    true if won_counter >= 1
  end

  def winning_count?(counter)
    counter == 3
  end

  def won?
    true if won_straight_line? == true || won_diagonal? == true
  end
end
