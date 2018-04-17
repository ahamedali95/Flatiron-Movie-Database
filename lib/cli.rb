require_relative "../config/environment.rb"
#
def list_commands
  "*************************************************"
  "  # 1. See list of Movies, Directors, Actors."
  "  # 2. Search Online for Available movies."
  "  # 3. Search Movies by Actor."
  "  # 4. Search Movies by Director."
  "  # 5. Top 3 rated Movies within our current db."
  "  # 6. Top 3 Box Office Movies within current db."
  "  # 7. Find Movies by MPAA Rating. Ex. PG-13"
  "  # 8. Search Movie by by decade"
  "  # 9. Search Movie by by Studio."
  "*************************************************"
  "Please enter an option from 1-9, 'e' to Exit. "
end

def sub_options
  puts "What would you like to do?"
  puts "A. See List of Movies."
  puts "B. See List of Directors."
  puts "C. See List of Actors.\n"
  puts "*** Press (e) to EXIT! ***"
  input = gets.chomp

end



def goodbye
  puts "Thank you for stopping bye!!"
  puts "GoodBye"
  abort
end

def print_one_list(input)
  case input


  end


def options
  input = gets.chomp

  case input
  when "e"
    goodbye
  when "1"
    input = sub_options
    print_one_list(input)
    else
      list_commands
      options
  end
  2. Search available movies online
  3. Search movies by actor
  4. Search movies by director
  5. Top 3 rated movies within our current database.
  6. Top 3 Box Office movies within db
  7. Find movies by MPAA Rating = PG-13
  8. Look up movie by decade
  9. Look up movies by studio.
end

#DO NOT CALL RUN in here.
def run
  # list_commands
  # welcome
end
#
#
# puts "Thanks for using mini-IMDB"
