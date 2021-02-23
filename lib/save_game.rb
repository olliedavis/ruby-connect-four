require 'json'
require_relative 'gameboard'

class SaveGame
  def initialize(save_name, current_player)
    @save_name = save_name
    @current_player = current_player
    current_board = Gameboard.new.board
    #@board = @gameboard.board
    game_save(@save_name, current_player, current_board)
  end

  def game_save(save_name, current_player, current_board)
    self_json = {
      current_board: current_board,
      current_player: current_player
    }.to_json
    open("../saves/#{save_name}.json", 'a') do |file|
      file.puts self_json
    end
  end

  def unique_file_name?(save_name)
    saves = Dir.entries('../saves/')
    saves.each do |save|
      return true unless save == "#{save_name}.json"
    end
    false
  end
end
