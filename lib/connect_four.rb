require 'pry'
require_relative 'gameboard'

class ConnectFour
  def initialize
    @gameboard = Gameboard.new
    @board = @gameboard.board
  end

  def intro
    puts 'Welcome to Connect Four. Please read the README if you are unsure how to play.'
    play
  end

  def play
    until over?
      @gameboard.current_board
      column = player_input(current_player)
      @gameboard.counter_drop(column, current_player)
    end
    if won?
      congrats(winner)
    else
      puts "It's a draw!"
      play_again?
    end
  end

  def player_input(char)
    puts "Player #{char[0]}, please enter the number of the column of where you would like to drop your token"
    input = gets.to_i - 1

    until valid?(input)
      puts 'Invalid input, please enter the number of the column of where you would like to drop your token'
      input = gets.to_i - 1
    end
    input
  end

  def valid?(int)
    int >= 0 && int <= 6 ? true : false
  end

  def current_player
    turn_count.even? ? 'X|' : 'O|'
  end

  def turn_count
    taken = 0
    @board.each do |row|
      row.each do |slot|
        taken += 1 if ['X|', 'O|'].include?(slot)
      end
    end
    taken
  end

  def won?
    @gameboard.won_straight_line? || @gameboard.won_diagonal?
  end

  def draw?
    @gameboard.full_board?
  end

  def over?
    won? || draw?
  end

  def winner
    #the reverse of current_player or else congrats calls the next player, not the winner
    turn_count.even? ? 'O|' : 'X|'
  end

  def congrats(player)
    @gameboard.current_board
    puts "Congratulations #{player[0]}, you win!"
    play_again?
  end

  def play_again?
    puts 'Play Again? Enter 1 for Yes, or 2 for No'
    gets.to_i == 1 ? game_start : exit
  end

end

def game_start
  game = ConnectFour.new
  game.intro
end

game_start