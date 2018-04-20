require_relative "../config/environment.rb"
gem "tty-font"

def welcome
  font = TTY::Font.new(:starwars)
  pastel = Pastel.new


  puts pastel.red(font.write("  WELCOME    TO"))
  puts pastel.red(font.write("            FLATIRON"))
  puts pastel.red(font.write("          DATABASE"))
  puts pastel.red(font.write("              MOVIE           CLI"))
  # puts "*"*45
  # puts "|                                     |"
  # puts "|       Welcometo Flatiron Movie      |".upcase
  # puts "|           Database Search           |".upcase
  # puts "|                                     |"
  # puts "="*45
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
  puts "  # 8. Search Movie by by decade"
  puts "  # 9. Search Movie by by Studio."
  puts "*************************************************"
  puts "Please enter an option from 1-9, 'e' to Exit. "

end

def sub_options
  puts "What would you like to do?"
  puts "A. See List of Movies."
  puts "B. See List of Actors."
  puts "C. See List of Directors.\n"
  puts "*"*45
  puts "Press (e) to EXIT!"
  puts "Press (r) to RETURN to Main Menu"
  input = gets.chomp.downcase
end

def goodbye
  font = TTY::Font.new(:starwars)
  pastel = Pastel.new

  puts pastel.red(font.write(" Thank   you   for"))
  puts pastel.red(font.write("  stopping           bye!!"))
  puts pastel.red(font.write("          GoodBye"))
  abort
  # puts "\n"*4
  # puts "*"*45
  # puts "|                                           |"
  # puts "|         Thank you for stopping bye!!      |".upcase
  # puts "|                 GoodBye                   |".upcase
  # puts "|                                           |"
  # puts "*"*45
  # puts "\n"*5
  # abort
end

def spacing
  equal_space_equal
  sleep(1)
end

def print_one_list(input)
  case input
    when "a"
      print_movies_list
      spacing
      options
    when "b"
      print_actors_list
      spacing
      options
    when "c"
      print_directors_list
      spacing
      options
    when "e"
      goodbye
    when "r"
      options
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
  spacing
  print_directors_list
  puts "\n"
  puts "Please enter a directors number: \n"
  puts "Press (e) to Exit || (r) Return to Main Menu."
  id = input_goodbye_return

  dm = DirectedMovie.all.where(director_id: id)
  case dm
    when []
      puts print_not_valid_option
      directors_movies
    else
      equal_space_equal
      dm.each do |mov|
          Movie.all.each_with_index do |join, index|
            if mov.movie_id == join.id
              puts "#{index +1}. #{join.title}"
            end
          end
          equal_space_equal
          options
      end
  end
end #directors_movies

def options
  print_list_commands
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
      search_api_for_movie(input)
    when "3"
      print_actors_list
      get_movies_by_actor_id

      #Then that methods calls spacing and options methods for all cases after this
    when "4"

      directors_movies
    when "5"
      get_top_three_movies_from_db


    when "6"
      find_top_3_gross
    when "7"
      get_movie_info_from_db_by_parental_rating
      spacing
      options
    when "8"
      decade_by_year
    when "9" # 9. Search Movie by by Studio."
      spacing
      studio_movies
    else
      puts "Not a valid option. Please try again: \n".upcase
      options
  end
end

def print_movies_list
  Movie.select(:id, :title).each do |movie_obj|
    puts "#{movie_obj.id}. #{movie_obj.title}"
  end
end

def print_actors_list
  Actor.select(:name, :id).each do |actor_obj|
    puts "#{actor_obj.id}. #{actor_obj.name}" if actor_obj.name != "N/A"
  end
end

def print_directors_list
  Director.select(:name, :id).each do |director_obj|
     puts "#{director_obj.id}. #{director_obj.name}" if director_obj.name != "N/A"
  end
end

def search_api_for_movie(input) #number2
  req = RestClient.get("http://www.omdbapi.com/?t=#{input}&apikey=485b50f7")
  res = JSON.parse(req)
  if res["Error"]== "Movie not found!" || res["Response"] == "False"
    puts "Movie not found!"
    options
  end
  check = Movie.find_by(title: res["Title"])
  # t = check.title.downcase
  case check
    when nil
      title = res["Title"]
      year = res["Year"].to_i
      rated = res["Rated"]
      released = res["Released"]
      genre = res["Genre"]
      director = res["Director"].split(",").first
      cast = res["Actors"]
      plot = res["Plot"]
      rating = res["imdbRating"].to_f
      !res["BoxOffice"] == nil? ? box_office = res["BoxOffice"] : box_office = "N/A"
      !res["Production"] == nil? ? production = res["Production"].gsub(/[^A-Za-z 0-9]/, "") : production = "other"
      d = Director.find_or_create_by(name: director)
      m = Movie.find_or_create_by(
        title: title,
        year: year,
        rated: rated,
        released: released,
        genre: genre,
        plot: plot,
        rating: rating,
        box_office: box_office,
        production: production)

      directed_movie_join = DirectedMovie.find_or_create_by(director_id: d.id, movie_id: m.id)
      actors = res["Actors"].split(", ")
        actors.each do |name|
          actor = Actor.find_or_create_by(name: name)
          cast_join = Cast.find_or_create_by(actor_id: actor.id, movie_id: m.id)
        end
        spacing
        puts "Title: #{title}"
        puts "Year: #{year}"
        puts "MPAA rating: #{rated}"
        puts "Release date: #{released}"
        puts "Genre: #{genre}"
        puts "*"*45
        puts "Director: #{director}"
        puts "Starring: #{cast}"
        puts "*"*45
        puts "Synopsis: #{plot}"
        puts "*"*45
        puts "IMDB Rating: #{rating}"
        puts "Box office gross: #{box_office}"
        spacing
        sleep(2)
        options
      else
        puts "That movie is already in the database. \n
        Here's some details about it:"
        equal_space_equal
        in_db = Movie.where("title LIKE (?)", "%#{input}%")
        in_db.each do |movie|
          puts "Title: #{movie.title}"
          puts "Year: #{movie.year}"
          puts "MPAA Rating: #{movie.rated}"
          puts "Release date: #{movie.released}"
          puts "Genre(s): #{movie.genre}"
          puts "*"*45
          puts "Director: #{   Movie.where({title: movie.title}).first.directors.first.name}"
          puts "Cast:"
          Movie.where({title: movie.title}).first.actors.each_with_index {|actor, index| puts "   #{index + 1}. #{actor.name}"}
          puts "Synopsis: #{movie.plot}"
          puts "*"*45
          puts "IMDB rating: #{movie.rating}"
          puts "Box office gross: #{movie.box_office}"
          puts "Studio: #{movie.production}"
        end
        equal_space_equal
        sleep(3)
        options
      end
end

# SELECT name FROM directors INNER JOIN directed_movies ON director_id = directors.id INNER JOIN movies ON movie_id = movie.id WHERE director_id = director.id && movie_id = in_db.id







# To-dos:
# 1. getting actor and director to work with the last else statement
# 2. error handling - crashes if input is gibberish

def get_movies_by_actor_id
  equal_space_equal
  puts "Please enter the actor's id: \n"
  puts "Press (e) to Exit || (r) Return to Main Menu."
  input = input_goodbye_return

  actor_ids = Actor.select(:id).map do |actor_obj|
    actor_obj.id.to_s
  end

  if input.empty? || !actor_ids.include?(input)
    puts "This is not a valid option"
    print_actors_list
    puts "Please try again: \n"
    get_movies_by_actor_id
  else
    actor_name = Actor.find(input).name
    equal_space_equal
    puts "\n"
    puts "#{actor_name} is part of:"
    movies = Movie.joins("INNER JOIN casts on movies.id = casts.movie_id AND casts.actor_id = #{input}")
    movies.each do |movie_obj|
      puts movie_obj.title
    end
    spacing
    options
  end

end

def get_top_three_movies_from_db
  movies = Movie.order("rating DESC")
  puts "1. #{movies[0].title} - #{movies[0].rating}"
  puts "2. #{movies[1].title} - #{movies[1].rating}"
  puts "3. #{movies[2].title} - #{movies[2].rating}"
  spacing
  sleep(4)
  options
end

def print_parental_ratings_list
  Movie.select(:rated).map do |movie_obj|
    movie_obj.rated
  end.uniq.each do |parental_rating|
    puts parental_rating if parental_rating != "N/A"
  end
end

def get_movie_info_from_db_by_parental_rating
  print_parental_ratings_list
  puts "Enter (e) to EXIT || (m) Return to Main Menu."
  puts "Please enter a rating: \n"

  input = gets.chomp
  goodbye if input.downcase == "e"
  options if input.downcase == "m"
  movies = Movie.where("rated LIKE ?", "%#{input}%")

  if movies.empty? || input.empty?
    puts "This is not a valid option"
    print_parental_ratings_list
    puts "Please try again: \n"
    get_movie_info_from_db_by_parental_rating
  else
    equal_space_equal
    movies.each_with_index do |movie_obj, index|
      puts "#{index + 1}. #{movie_obj.title} - #{movie_obj.rated}"
    end
  end
end

def print_not_valid_option
  equal_space_equal
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
  puts "-"*45
  puts "(e) to EXIT || (r) Return to Main menu "
end

def equal_space_equal
  puts "="*45
  puts "\n"
  puts "="*45
end
#RRR
def studio_movies
  print_studio_list
  equal_space_equal

  puts "Please enter a studio name: \n".upcase
  input = input_goodbye_return
  movies = Movie.all.where("production LIKE ?", "%#{input}%")
  case movies
    when [] || nil
      print_not_valid_option
      print_studio_list
      puts "Please type a name from the list: "
      studio_movies

    else
      puts "*"*45
      puts "\n"
      movies.each_with_index do |movie, index|
        puts " #{index+1}. #{movie.title}"
      end
      puts "\n"
      sleep(2)
      options
  end
end

def find_top_3_gross #6
  equal_space_equal
  response = Movie.where.not(box_office: [nil, ""])

  unsorted = response.each {|movie|
    movie.box_office = movie.box_office.gsub(/[^0-9 ]/i, '').to_i
  }
  sorted = unsorted.sort_by do |movie|
    movie[:box_office].to_i
  end
  result = sorted.reverse
  puts "The following are the top 3 grossing movies within our database: "
  puts "1. #{result[0].title}  || Gross Amount:  $#{result[0].box_office}"
  puts "2. #{result[1].title}  || Gross Amount:  $#{result[1].box_office}"
  puts "3. #{result[2].title}  || Gross Amount:  $#{result[2].box_office}"

  spacing
  sleep(3)
  options

end

def print_decade_example
  equal_space_equal
  puts "Please enter a year: \n".upcase

  puts "Enter a year and we will return \n"
  puts "any movies found within that decade.\n"
  puts "Example: 1995"
  puts "Will return all movies from 1990-1999.\n"
  puts "Enter (e) to EXIT || (r) Return to Main Menu."
  #goes to decade by year method
end

def not_valid_length #part of 8
  puts "Not a valid length.\n"
  decade_by_year
end

def input_goodbye_return
  input = gets.chomp
  goodbye if input.downcase == "e"
  options if input.downcase == "r"
  input
end

def decade_by_year # 8. Search Movie by by decade"
  print_decade_example
  input = input_goodbye_return
  not_valid_length if input.length < 4 && input.length > 4
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
      decade_by_year
    when nil
      puts "No Movies found for that year."
      puts "Please try again: \n"
      decade_by_year
    else
      puts "*"*45
      puts "\n"
      puts " YEAR RELEASED  ||    TITLE             |"
      results.each_with_index do |movie, index|
        puts " #{index+1}. #{movie.year} #{movie.title}"
    end
    puts "\n"
    sleep(2)
    options
  end
end

  #DO NOT CALL RUN in here.
  def run
    welcome
    options
  end
