require 'json'
require_relative 'gameboard'
require_relative 'connect_four'

class SaveGame
  def initialize(save_name, current_board, current_player)
    @save_name = save_name
    @current_board = current_board
    @current_player = current_player
    @connect_four = ConnectFour
    game_save(@save_name)
  end

  def game_save(save_name)
    self_json = {
      current_board: @current_board,
      current_player: @current_player
    }.to_json
    open("../save/#{save_name}.json", 'a') do |file|
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
