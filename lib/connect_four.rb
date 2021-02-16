require_relative 'gameboard'

class ConnectFour
  def initialize
    @board = Gameboard.new
    @player_count = 0
    # play
  end

  def player_input
    # puts "Player #{player_number}, please enter the number of the column of where you would like to drop your token"
    input = gets.chomp.to_i - 1

    until valid?(input)
      puts 'Invalid input, please enter the number of the column of where you would like to drop your token'
      input = gets.chomp.to_i - 1
    end
    input
  end

  def valid?(int)
    int >= 1 && int <= 7 ? true : false
  end

  def player_turn
    @player_count.zero? ? 'O|' : 'X|'
  end

end
