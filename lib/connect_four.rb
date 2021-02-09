require_relative 'gameboard'

class ConnectFour
  def initialize
    @board = Gameboard.new
  end

  def input_to_index(int)
    int - 1
  end

  def valid?(int)
    int >= 1 && int <= 7 ? true : false
  end

end
