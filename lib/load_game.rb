require 'json'

class LoadGame
  def load_file
    puts 'Which one is the name of your save file?'
    begin
      retrieve_files
      user_save = gets.chomp
      save = File.read("../saves/#{user_save}.json")
    rescue StandardError
      puts 'File not found. Going back to main menu.'
    end
    JSON.parse(save)
  end

  def retrieve_files
    saves = Dir.entries('../saves/')
    saves.each do |save_file|
      puts File.basename(save_file, '.json') unless save_file =~ /^..?$/
    end
  end
end
