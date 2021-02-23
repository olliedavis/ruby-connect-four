require 'json'

class LoadGame
  
  def load_file
    puts 'Which file is the name of your save?'
    retrieve_files
    user_save = gets.chomp
    until File.exist?("../saves/#{user_save}.json")
      puts 'File not found, try again'
      user_save = gets.chomp
    end
    JSON.parse(File.read("../saves/#{user_save}.json"))
  end

  def retrieve_files
    saves = Dir.entries('../saves/')
    saves.each do |save_file|
      puts File.basename(save_file, '.json') unless save_file =~ /^..?$/
    end
  end
end


def load_file
  puts 'Which file is the name of your save?'
  retrieve_files
  user_save.gets.chomp
  until user_save == File.read("../saves/#{user_save}.json")
    puts 'File not found, try again'
    load_file
  end
  save = File.read("../saves/#{user_save}.json")
  JSON.parse(save)
end