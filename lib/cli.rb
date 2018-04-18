require_relative "../config/environment.rb"
gem "tty-font"

def welcome
  font = TTY::Font.new(:starwars)
  pastel = Pastel.new


  puts pastel.red(font.write("  WELCOME"))
  puts pastel.red(font.write("                       TO"))
  puts pastel.red(font.write("FLATIRON"))
  puts pastel.red(font.write("           MOVIE"))

  puts pastel.red(font.write("DATABASE"))
  puts pastel.red(font.write("                       CLI"))
  # puts "*"*45
  # puts "|                                     |"
  # puts "|       Welcometo Flatiron Movie      |".upcase
  # puts "|           Database Search           |".upcase
  # puts "|                                     |"
  # puts "="*45
end

def print_list_commands_with_options
  puts "*************************************************"
  puts "  # 1. See list of Movies, Directors, Actors."
  puts "  # 2. Search Online for Available movies."
  puts "  # 3. Search Movies by Actor."
  puts "  # 4. Search Movies by Director."
  puts "  # 5. Top 3 rated Movies within our current db."
  puts "  # 6. Top 3 Box Office Movies within current db."
  puts "  # 7. Find Movies by MPAA Rating. Ex. PG-13"
  puts "  # 8. Search Movie by by decade"
  puts "  # 9. Search Movie by by Studio."
  puts "*************************************************"
  puts "Please enter an option from 1-9, 'e' to Exit. "
  options
end

def get_movie_info_from_db
  Movie.select(:id, :title).each do |movie_obj|
    puts "#{movie_obj.id}. #{movie_obj.title}"
  end
end

def get_actor_info_from_db
  Actor.select(:name, :id).each do |actor_obj|
    puts "#{actor_obj.id}. #{actor_obj.name}" if actor_obj.name != "N/A"
  end
end

def get_director_info_from_db
  Director.select(:name, :id).each do |director_obj|
     puts "#{director_obj.id}. #{director_obj.name}" if director_obj.name != "N/A"
  end
end
# 3. Search movies by actor
#
# #Movie.joins(casts: :actor).where("actors.name = ?, 'Marlon Brando'")
#
# SELECT movies.name FROM movies
# INNER JOIN casts
# ON movies.id = movie_id
# INNER JOIN actors
# ON casts.actor_id = actors.id
# WHERE actors.name = "hugh jackman"

def get_top_three_movies_from_db
  movies = Movie.order("rating DESC")
  puts movies[0]
  puts movies[1]
  puts movies[2]
end

def get_all_parental_ratings_from_db
  Movie.select(:rated).map do |movie_obj|
    movie_obj.rated
  end.uniq.each do |parental_rating|
    puts parental_rating
  end
end


#
# Movie.where(rated: <input>) <-- needs error handling in case some smartass puts in XXX - MDT
# 8. Look up movie by decade
# This one's gonna take some doing, but I have a few ideas. -MDT

def sub_options
  puts "What would you like to do?"
  puts "A. See List of Movies."
  puts "B. See List of Directors."
  puts "C. See List of Actors.\n"
  puts "**************************************"
  puts "Press (e) to EXIT!"
  puts "Press (r) to RETURN to Main Menu"
  input = gets.chomp.downcase
end

def goodbye
  puts "\n"
  puts "\n"
  puts "*"*45
  puts "|       Thank you for stopping by!!      |".upcase
  puts "|                GoodBye                   |".upcase
  puts "*"*45

  abort
end

def spacing
  puts "="*40
  puts "\n"
  puts "="*40
  sleep(2)
end

def print_one_list(input)
  case input
    when "a"
      get_movie_info_from_db
      spacing
      print_list_commands_with_options

    when "b"
      get_actor_info_from_db
      spacing
      print_list_commands_with_options

    when "c"
      get_director_info_from_db
      spacing
      print_list_commands_with_options

    when "e"
      goodbye
    when "r"
      print_list_commands_with_options

    else
      input = sub_options
      print_one_list(input)
  end
end

def options
  input = gets.chomp

  case input
    when "e"
      goodbye
    when "1"
      input = sub_options
      print_one_list(input)
    when "2"
      puts "Please enter a movie title: \n"
      input = gets.chomp

      #get_movie_info_from_db
    when "3"
      puts "Please enter an actors name: \n"
      input = gets.chomp
      #A method
    when "4"
      puts "Please enter a directors name: \n"
      input = gets.chomp
      # method(input)
    when "5"
      get_top_three_movies_from_db
      sleep(3)
      print_list_commands_with_options

    when "6"
      find_top_3_gross
      spacing
      # method created by M||A
      sleep(3)
      print_list_commands_with_options

    when "7"
      get_movie_ratings_from_db
      puts "Please enter a rating: \n"
      input = gets.chomp
      #gets movie info by db from MB
      get_movie_info_from_db_by_parental_rating(input)
    when "8"
      input = print_decade_example
      # need to get a list of range #TODO
      decade_by_year(input)
      # method(input)
    when "9" # 9. Search Movie by by Studio."
      spacing
      print_studio_list
      # need to get a list of range #TODO
      puts "="*45
      puts "Please enter a studio name: \n".upcase
      input = gets.chomp.downcase
      goodbye if input == "e"
      studio_movies(input)
      puts "$"*40
      puts "="*40
      print_list_commands_with_options

    else
      puts "Not a valid option. Please try again: \n".upcase
      print_list_commands_with_options
  end
end



def print_studio_list
  m = Movie.all.map do |movie|
    movie.production
  end.uniq
  a = m.each_with_index do |prod, index|
    puts "#{index+1}. #{prod}"
  end
end


def get_movie_info_from_db_by_parental_rating(p_rating)
  formatted_rating = p_rating.downcase.split("-").join("")
  index = 0
  Movie.where(rated: formatted_rating).each do |movie_obj|
    if formatted_rating == movie_obj.rated.downcase.split("-").join("")
      index += 1
      puts "#{index}. #{movie_obj.title}"
    end
  end
end

def print_not_valid_option
  puts "="*45
  puts "\n"
  puts "\n"
  puts "="*45
  puts "Not a valid option.".upcase
  puts "Please try again: \n"
  puts "="*45
  sleep(2)
end

#RRR
def studio_movies(input)
  # input = input.split.map(&:capitalize).join(' ')
  goodbye if input == "e"
  movies = Movie.all.where("production LIKE ?", "%#{input}%")
  case movies
    when []
      print_not_valid_option
      print_studio_list
      puts "Please type a name from the list: "
      input = gets.chomp
      studio_movies(input)

    when nil
      print_not_valid_option
      print_studio_list
      puts "Please type a name from the list: "
      input = gets.chomp
      studio_movies(input)
    else
      puts "*"*45
      puts "\n"
      movies.each_with_index do |movie, index|
        puts " #{index+1}. #{movie.title}"
      end
      puts "\n"
      sleep(2)
      print_list_commands_with_options
  end

end

def find_top_3_gross #6
  response = Movie.where.not(box_office: [nil, ""])

  unsorted = response.each {|movie|
    movie.box_office = movie.box_office.gsub(/[^0-9 ]/i, '').to_i
  }
  sorted = unsorted.sort_by do |movie|
    movie[:box_office].to_i
    end
  result = sorted.reverse
  # make sure to add the amount they grossed box office.
  #make it look nice.
  puts result[0].title
  puts result[1].title
  puts result[2].title
end

def print_decade_example
  puts "\n"
  puts "\n"
  puts "*"*45
  puts "Please enter a year: \n".upcase

  puts "Enter a year and we will return \n"
  puts "any movies found within that decade.\n"
  puts "Example: 1995"
  puts "Will return all movies from 1990-1999.\n"
  input = gets.chomp
end

def not_valid_length
  puts "Not a valid length.\n"
  input = print_decade_example
  decade_by_year(input)
end

def decade_by_year(input) # 8. Search Movie by by decade"
  goodbye if input == "e"
  not_valid_length if input.length < 4
  array1 = input.split("")
  array2 = input.split("")
  array1[3] = "0"
  array2[3] = "9"
  zero = array1.join.to_i
  nine = array2.join.to_i
  results = Movie.all.where(
  "year > ? AND year < ?", zero, nine)
  case results
    when []
      puts "No Movies found for that year."
      puts "Please try again: \n"
      input = print_decade_example
      decade_by_year(input)
    when nil
      puts "No Movies found for that year."
      puts "Please try again: \n"
      input = print_decade_example
      decade_by_year(input)
    else
      puts "*"*45
      puts "\n"
      puts " YEAR RELEASED  ||    TITLE             |"
      results.each_with_index do |movie, index|
        puts " #{index+1}. #{movie.year} #{movie.title}"
    end
    puts "\n"
    sleep(2)
  end


end





  #DO NOT CALL RUN in here.
  def run
    welcome
    print_list_commands_with_options


  end
