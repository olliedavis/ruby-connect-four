require_relative 'gameboard'
require_relative 'save_game'
require_relative 'load_game'

class ConnectFour
  def initialize
    @gameboard = Gameboard.new
    @board = @gameboard.board
  end

  def intro
    puts 'Welcome to Connect Four. Feel free to press 8 at anytime to save, or 9 to load a previous save.'
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

  # converts 1 - 7 to 0 - 6 to match array index
  def player_input(char)
    puts "Player #{char[0]}, please enter the number of the column of where you would like to drop your token"
    input = gets.to_i - 1

    until save_load_valid?(input)
      puts 'Please enter the number of the column of where you would like to drop your token'
      input = gets.to_i - 1
    end
    input
  end

  def save_load_valid?(input)
    case input
    when 0..6
      return true
    when 7
      game_save
    when 8
      game_load
    end
    false
  end

  def current_player
    turn_count.even? ? 'X|' : 'O|'
  end

  # iterates through each slot and checks if taken
  def turn_count
    taken = 0
    @gameboard.board.each do |row|
      row.each do |slot|
        taken += 1 if ['X|', 'O|'].include?(slot)
      end
    end
    taken
  end

  def won?
    @gameboard.won_horizontal? || @gameboard.won_vertical? || @gameboard.won_diagonal?
  end

  def draw?
    @gameboard.full_board?
  end

  def over?
    won? || draw?
  end

  # the reverse of current_player or else congrats calls the next player, not the winner
  def winner
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

  def game_save
    puts 'Please enter a name for your save file'
    save_name = gets.chomp
    if unique_file_name?(save_name)
      SaveGame.new(save_name, @gameboard.board)
      puts 'Game saved successfully!'
      play
    else
      puts 'Save Failed - Name already exists'
      game_save
    end
  end

  def game_load
    content = LoadGame.new.load_file
    @gameboard.board = content['current_board']
    loaded
  end

  def loaded
    puts "Game loaded! Here's a reminder of where you left off"
    puts "Current Player: #{current_player} Current Board:"
    play
  end

  def unique_file_name?(save_name)
    saves = Dir.entries('../saves/')
    return true if saves.all? { |save| save != "#{save_name}.json" }

    return false
  end
end

def game_start
  game = ConnectFour.new
  game.intro
end

game_start
