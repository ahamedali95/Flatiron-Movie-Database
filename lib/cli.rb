require_relative "../config/environment.rb"

#

def welcome
  puts "*"*45
  puts "|                                     |"
  puts "|       Welcometo Flatiron Movie      |".upcase
  puts "|           Database Search           |".upcase
  puts "|                                     |"
  puts "="*45
end

def print_list_commands
  puts "*************************************************"
  puts "  # 1. See list of Movies, Directors, Actors."
  puts "  # 2. Search Online for Available movies."
  puts "  # 3. Search Movies by Actor."
  puts "  # 4. Search Movies by Director."
  puts "  # 5. Top 3 rated Movies within our current db."
  puts "  # 6. Top 3 Box Office Movies within current db."
  puts "  # 7. Find Movies by MPAA Rating. Ex. PG-13"
  puts "  # 8. Search Movie by Decade"
  puts "  # 9. Search Movie by Studio."
  puts "*************************************************"
  puts "Please enter an option from 1-9, 'e' to Exit. "
end
# # 1a. See Available movies within database
def get_movie_info_from_db
  Movie.select(:id, :title).each do |movie_obj|
    puts "#{movie_obj.id}. #{movie_obj.title}"
  end
end
# # 1b. See available actors.
def get_actor_info_from_db
  Actor.select(:name, :id).each do |actor_obj|
    puts "#{actor_obj.id}. #{actor_obj.name}" if actor_obj.name != "N/A"
  end
end
# # 1c. See available directors.
def get_director_info_from_db
  Director.select(:name, :id).each do |director_obj|
     puts "#{director_obj.id}. #{director_obj.name}" if director_obj.name != "N/A"
  end
end

# # 2. Search available movies online
# # 3. Search movies by actor
#
# #Movie.joins(casts: :actor).where("actors.name = ?, 'Marlon Brando'")
#
# # SELECT movies.name FROM movies
# # INNER JOIN casts
# # ON movies.id = movie_id
# # INNER JOIN actors
# # ON casts.actor_id = actors.id
# # WHERE actors.name = "hugh jackman"
#
#
# # 4. Search movies by director
# # Movie.where(director: <input>) <-- needs error handling, will do tomorrow -MDT
# # 5. Top 3 rated movies within our current database.
def get_top_three_movies_from_db
  movies = Movie.order("order DESC")
  puts movies[0]
  puts movies[1]
  puts movies[2]
end

# # Movie.order(rating: :desc).limit(3)
#
# # 6. Top 3 Box Office movies within db
# # Movie.order(box_office: :desc).limit(3)
# # 7. Find movies by MPAA Rating = PG-13
def get_movie_info_from_db_by_parental_rating(rating)
  Movie.where(rated: rating).select(:title, :id).each do |movie_obj|
    puts "#{movie_obj.id}. #{movie_obj.title}"
  end
end
# # 8. Look up movie by decade
#
# # 9. Look up movies by studio.
# #SELECT * FROM movies WHERE production = "green studios"
# Movie.where(production: "whatever")
#
#
#
# # Movie.where(rated: <input>) <-- needs error handling in case some smartass puts in XXX - MDT
# # 8. Look up movie by decade
# # This one's gonna take some doing, but I have a few ideas. -MDT
# # 9. Look up movies by studio.


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
  puts "Thank you for stopping bye!!"
  puts "GoodBye"
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
      print_list_commands
      options
    when "b"
      get_actor_info_from_db
      spacing
      print_list_commands
      options
    when "c"
      get_director_info_from_db
      spacing
      print_list_commands
      options
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
      print_list_commands
      options
    when "6"
      find_top_3_gross
      spacing
      # method created by M||A
      sleep(3)
      print_list_commands
      options
    when "7"
      # need to get a list of the ratings #TODO
      puts "Please enter a rating: \n"
      input = gets.chomp
      get_movie_info_from_db_by_parental_rating
    when "8"
      # need to get a list of range #TODO
      puts "Please enter a decade: \n"
      input = gets.chomp
      # method(input)
    when "9" # 9. Search Movie by by Studio."
      print_studio_list
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

def print_studio_list
  arr =[]
  m = Movie.all.select do |mov|
    if !mov.production.nil?
      prod = mov.production.gsub(/[^A-Za-z 0-9]/, "")
      arr <<  prod
    end
  end
  arr = arr.uniq
  a = arr.each_with_index do |prod, index|
    puts "#{index+1}. #{prod}"
  end
  # binding.pry
end



def find_top_3_gross #6
  Movie.order(box_office: :desc).limit(3)
end

def find_by_decade(input)
  if input.length < 4
    puts "Please enter the decade in 4-digit format, i.e. '1980s.''"
    input = gets.chomp
  else
  int_input = input.to_i
  binding.pry
  Movie.scoped(:conditions => { :released => int_input...int_input+9 })
  end

end





  #DO NOT CALL RUN in here.
  def run
    welcome
    print_list_commands
    options

  end
