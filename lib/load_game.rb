require 'json'
require_relative 'connect_four'

class Load

  def initialize(current_board, current_player)
    @current_board = current_board
    @current_player = current_player
    @connect_four = ConnectFour
    load_file
  end

  def load_file
    puts 'Which one is the name of your save file?'
    begin
      retrieve_files
      user_save = gets.chomp
      save = File.read("../saves/#{user_save}.json")
    rescue StandardError
      puts 'File not found. Going back to main menu.'
    end
    content = JSON.parse(save)
    load_save(content)
  end

  def retrieve_files
    saves = Dir.entries('../saves/')
    saves.each do |save_file|
      puts File.basename(save_file, '.json') unless save_file =~ /^..?$/
    end
  end

end

