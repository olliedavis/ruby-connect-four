require_relative 'gameboard'

class ConnectFour
  def initialize
    @gameboard = Gameboard.new
    @board = @gameboard.board
    intro
  end

  def intro
    puts 'Welcome to Connect Four. Please read the README if you are unsure how to play.' < "\n"
    play
  end

  def play
    until over?
      @gameboard.current_board
      column = player_input(current_player)
      @gameboard.counter_drop(column, current_player)
    end
    if won?
      congrats(current_player)
    else
      puts "It's a draw!"
      play_again?
    end
  end

  def player_input(char = current_player[0])
    puts "Player #{char}, please enter the number of the column of where you would like to drop your token"
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

  def congrats(player)
    puts "Congratulations #{player}, you win!"
    play_again?
  end

  def play_again?
    puts 'Play Again? Enter 1 for Yes, or 2 for No'
    gets.chomp_to_i == 1 ? game_start : exit
  end

  def game_start
    game = ConnectFour.new
    game.play
  end
end
