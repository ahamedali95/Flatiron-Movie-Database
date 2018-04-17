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
puts "Welcome to mini-IMDB

puts "Enter a movie name: "
input = gets.chomp
