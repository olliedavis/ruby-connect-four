class Gameboard
  def initialize
    board
  end

  def board
    @row_one = [' '] * 7
    @row_two = [' '] * 7
    @row_three = [' '] * 7
    @row_four = [' '] * 7
    @row_five = [' '] * 7
    @row_six = [' '] * 7
  end

  def counter_drop(column, player)
    position = counter_drop_position(column)
    position[column] = player
  end

  def counter_drop_position(column)
    case ' '
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
end
