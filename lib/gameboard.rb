class Gameboard
  def initialize
    board
    @empty_space = ' |'
  end

  def board
    @board_array = [
      @row_one = [' |'] * 7,
      @row_two = [' |'] * 7,
      @row_three = [' |'] * 7,
      @row_four = [' |'] * 7,
      @row_five = [' |'] * 7,
      @row_six = [' |'] * 7
    ]
  end

  def current_board
    puts 'Here is the current board:'
    @board_array.each do |row|
      puts row.join
    end
  end

  def counter_drop(column, player)
    position = counter_drop_position(column)
    position[column] = player
  end

  def counter_drop_position(column)
    case @empty_space
    when @row_six[column]
      @row_six
    when @row_five[column]
      @row_five
    when @row_four[column]
      @row_four
    when @row_three[column]
      @row_three
    when @row_two[column]
      @row_two
    when @row_one[column]
      @row_one
    end
  end

  def full_board?
    full_row = 0
    @board_array.each do |row|
      full_row += 1 if row.include?(' |') == false
    end
    true if full_row == 6
  end

  def won_straight_line?
    @board_array.each do |row|
      row.reverse.each_with_index do |int, idx|
        int[idx] != @empty_space && int[idx] == int[idx + 1] && int[idx] == int[idx + 2] && int[idx] == int[idx + 3] ? true : false
      end
    end
  end

  def won_diagonal?
    correct_counter = 0
    @board_array.reverse.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        if col[col_idx] != @empty_space && col[col_idx] == row[row_idx + 1][col[col_idx + 1]]
          correct_counter += 1
        else
          correct_counter = 0
        end
      end
    end
    true if correct_counter == 4
  end
end

#