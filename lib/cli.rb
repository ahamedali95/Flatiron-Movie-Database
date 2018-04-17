require_relative "../config/environment.rb"
#
def list_commands
  "Available commands: "
  "  - List all commands [l]"
  "  - Exit the program [e]"
  "  - Info About a movie [title: ?]"
  "  - Find actors' movies [actor: ?]"
  "  - Find directors' movies [director: ?]"
  "  - Find popular movie [popular]"
  "  - Find oldest movie  [oldest]"
  "  - Find highest grosser [highest]"
  "  - Find latest release [latest]"
end

def run
  puts "Welcome to mini-IMDB"
  puts list_commands
  input = gets.chomp().downcase

  while input != "e"
    if input == "l"
      puts list_commands
    elsif input == input.start_with("t")
      #query the movie info in the database. If not exists, go query it from
      #the API and seed to the database and then return the information
    elsif input == input.start_with("a")
    elsif input == input.start_with("d")
    else
      puts "Please follow the commands"
    end
  end
end

run
puts "Thanks for using mini-IMDB"
