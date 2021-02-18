require_relative 'gameboard'

class ConnectFour
  def initialize
    @gameboard = Gameboard.new
    @board = @gameboard.board
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

  def current_player
    turn_count.even? ? 'X|' : 'O|'
  end

  def turn_count
    taken = 0
    @board.each do |row|
      row.each do |slot|
        taken += 1 if slot == 'X|' || slot == 'O|'
      end
    end
    taken
  end
end
