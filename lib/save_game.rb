require 'json'

class SaveGame
  def initialize(save_name, current_board)
    game_save(save_name, current_board)
  end

  def game_save(save_name, current_board)
    self_json = {
      current_board: current_board
    }.to_json
    open("../saves/#{save_name}.json", 'a') do |file|
      file.puts self_json
    end
  end
end
