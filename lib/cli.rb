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
  puts "|       Thank you for stopping bye!!      |".upcase
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

def print_directors_list
  Director.all.each do |direct|
    puts "#{direct.id}. #{direct.name}"
  end


end

def directors_movies
  puts "Please enter a directors number: \n"
  puts "Press (e) to Exit || (r) Return to Main Menu."
  id = gets.chomp
  goodbye if id =="e"
  options if id == "r"
  check = id.to_i
  if check < 1
    puts print_not_valid_option
    print_directors_list
    directors_movies
  end
  dm = DirectedMovie.all.where(director_id: id)
  count = 1
  final = dm.each do |mov|
      Movie.all.select do |join|
        if mov.movie_id == join.id

          puts "#{count}. #{join.title}"
          count+=1
        end
    end
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
      get_movie_info_online(input)
    when "3"
      get_actor_info_from_db
      puts "Please enter the actor's id: \n"
      input = gets.chomp
      get_movies_by_actor_id(input)
      print_list_commands_with_options
    when "4"
      # 4. Search Movies by Director.
      spacing
      print_directors_list
      puts "\n"
      directors_movies
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
      get_all_parental_ratings_from_db
      puts "Please enter a rating: \n"
      input = gets.chomp
      get_movie_info_from_db_by_parental_rating(input)
    when "8"
      input = print_decade_example
      # need to get a list of range #TODO
      decade_by_year(input)
      # method(input)
    when "9" # 9. Search Movie by by Studio."
      spacing
      print_studio_list
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

def get_movie_info_online(input)
  req = RestClient.get("http://www.omdbapi.com/?t=#{input}&apikey=485b50f7")
  res = JSON.parse(req)
  title = res["Title"]
  year = res["Year"].to_i
  rated = res["Rated"]
  released = res["Released"]
  genre = res["Genre"]
  director = res["Director"].split(",").first
  plot = res["Plot"]
  rating = res["imdbRating"].to_f
  !res["BoxOffice"] == nil? ? box_office = res["BoxOffice"] : box_office = "N/A"
  !res["Production"] == nil? ? production = res["Production"].gsub(/[^A-Za-z 0-9]/, "") : production = "other"
  new_film = Movie.create(title: title, year: year, rated: rated, released: released, genre: genre, plot: plot, rating: rating, box_office: box_office, production: production)

  # new_film.each do |key, value|
  #   puts key + ' : ' + value
end

  #This should work, but for some reason I can't call .each on new_film. -MDT


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
def get_movies_by_actor_id(actor_id)
  sql_statement = "INNER JOIN casts on movies.id = casts.movie_id AND casts.actor_id = #{actor_id}"
  movies = Movie.joins(sql_statement)

  if movies.empty?
    get_actor_info_from_db
    puts "Invalid entry. Please enter a number from the list: "
    get_movies_by_actor_id(gets.chomp)
  else
    actor_name = Actor.find(actor_id).name
    puts "#{actor_name} is part of:"
    movies.each do |movie_obj|
      puts movie_obj.title
    end
  end
end

def get_top_three_movies_from_db
  movies = Movie.order("rating DESC")
  puts "1. #{movies[0].title} - #{movies[0].rating}"
  puts "2. #{movies[1].title} - #{movies[1].rating}"
  puts "3. #{movies[2].title} - #{movies[2].rating}"
end

def get_all_parental_ratings_from_db
  Movie.select(:rated).map do |movie_obj|
    movie_obj.rated
  end.uniq.each do |parental_rating|
    puts parental_rating
  end
end

def get_movie_info_from_db_by_parental_rating(p_rating)
  formatted_rating = p_rating.downcase
  movies = Movie.where("rated LIKE ?", "%#{formatted_rating}%")

  if movies.empty? || p_rating.empty?
    puts "This is not a valid option"
    get_all_parental_ratings_from_db
    puts "Please try again: \n"
    get_movie_info_from_db_by_parental_rating(gets.chomp)
  else
    movies.each_with_index do |movie_obj, index|
      puts "#{index + 1}. #{movie_obj.title} - #{movie_obj.rated}"
    end
    print_list_commands_with_options
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

def print_studio_list
  m = Movie.all.map do |movie|
    movie.production
  end.uniq
  a = m.each_with_index do |prod, index|
    puts "#{index+1}. #{prod}"
  end
end

#RRR
def studio_movies(input)
  # input = input.split.map(&:capitalize).join(' ')
  goodbye if input == "e"
  movies = Movie.all.where("production LIKE ?", "%#{input}%")
  case movies
    when [] || nil
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

  puts "The highest grossing movie in our database is #{result[0].title}, which made $#{result[0].box_office} at the box office."
  puts "The second-highest grossing movie in our database is #{result[1].title}, which made $#{result[1].box_office} at the box office."
  puts "Finally, the third-highest grossing movie in our database is #{result[2].title}, which made $#{result[2].box_office} at the box office."
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
end
