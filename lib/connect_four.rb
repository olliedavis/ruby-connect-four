require_relative 'gameboard'

class ConnectFour
  def initialize
    @board = Gameboard.new
  end

  def valid?(int)
    int >= 1 && int <= 7 ? true : false
  end
  
end
