require_relative "../config/environment.rb"
require "pry"
#
def print_list_commands
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
# 1a. See Available movies within database
def get_movie_infor_from_db
  Movie.select(:title).map do |movie_obj|
    movie_obj.title
  end
end
# 1b. See available actors.
Actor.select(:name).map do |actor_obj|
  actor_obj.name
end
# 1c. See available directors.
Director.select(:name).map do |director_obj|
  director_obj.name
end
# 2. Search available movies online
# 3. Search movies by actor

#Movie.joins(casts: :actor).where("actors.name = ?, 'Marlon Brando'")

# SELECT movies.name FROM movies
# INNER JOIN casts
# ON movies.id = movie_id
# INNER JOIN actors
# ON casts.actor_id = actors.id
# WHERE actors.name = "hugh jackman"


# 4. Search movies by director
# Movie.where(director: <input>) <-- needs error handling, will do tomorrow -MDT
# 5. Top 3 rated movies within our current database.
# movies = Movie.order("order DESC")
# [movies[0], movies[1], movies[2]]
# # Movie.order(rating: :desc).limit(3)
# # 6. Top 3 Box Office movies within db
# # Movie.order(box_office: :desc).limit(3)
# # 7. Find movies by MPAA Rating = PG-13
# Movie.where(rated: "PG-13")
# # 8. Look up movie by decade
#
# # 9. Look up movies by studio.
# #SELECT * FROM movies WHERE production = "green studios"
# Movie.where(production: "whatever")
# Movie.where(rated: <input>) <-- needs error handling in case some smartass puts in XXX - MDT
# 8. Look up movie by decade
# This one's gonna take some doing, but I have a few ideas. -MDT
# 9. Look up movies by studio.
# Movie.where(production: <input>) <-- See #4. -MDT



def sub_options
  puts "What would you like to do?"
  puts "A. See List of Movies."
  puts "B. See List of Directors."
  puts "C. See List of Actors.\n"
  puts "**************************************"
  puts "Press (e) to EXIT!"
  puts "Press (r) to RETURN to Main Menu"
  input = gets.chomp

end

def goodbye
  puts "Thank you for stopping bye!!"
  puts "GoodBye"
  abort
end

def print_one_list(input)
  case input
    when "A"
      # add method created by M/A
    when "B"
      # add method created by M/A
    when "C"
      # add method created by M/A
    when "e"
      goodbye
    when "r"
      print_list_commands
      options
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

      # method(input)
    when "3"
      puts "Please enter an actors name: \n"
      input = gets.chomp
      #A method
    when "4"
      puts "Please enter a directors name: \n"
      input = gets.chomp
      # method(input)
    when "5"
      # method created by M||A
      sleep(3)
      print_list_commands
      options
    when "6"
      # method created by M||A
      sleep(3)
      print_list_commands
      options
    when "7"
      # need to get a list of the ratings #TODO
      puts "Please enter a rating: \n"
      input = gets.chomp
      # method(input)
    when "8"
      # need to get a list of range #TODO
      puts "Please enter a decade: \n"
      input = gets.chomp
      # method(input)
    when "9"
      # need to get a list of range #TODO
      puts "Please enter a studio name: \n"
      input = gets.chomp
      # method(input)

    else
      print_list_commands
      options
  end
  # 2. Search available movies online
  # 3. Search movies by actor
  # 4. Search movies by director
  # 5. Top 3 rated movies within our current database.
  # 6. Top 3 Box Office movies within db
  # 7. Find movies by MPAA Rating = PG-13
  # 8. Look up movie by decade
  # 9. Look up movies by studio.
end

#DO NOT CALL RUN in here.
def run
  # print_list_commands
  # welcome
end
#
#
# puts "Thanks for using mini-IMDB"
