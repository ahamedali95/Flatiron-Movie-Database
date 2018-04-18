require_relative "../config/environment.rb"
require "pry"
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
# 1a. See Available movies within database
Movie.select(:title).map do |movie_obj|
  movie_obj.title
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
movies = Movie.order("order DESC")
[movies[0], movies[1], movies[2]]
# 6. Top 3 Box Office movies within db
# Movie.order(box_office: :desc).limit(3)
# 7. Find movies by MPAA Rating = PG-13
Movie.where(rated: "PG-13")
# 8. Look up movie by decade

# 9. Look up movies by studio.
#SELECT * FROM movies WHERE production = "green studios"
Movie.where(production: "whatever")



def welcome
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
      #SELECT * FROM actors
      #INNER JOIN casts
      #on actors.id = casts.actor_id
      #WHERE movies.id = actors.movie_id
    elsif input == input.start_with("d")
      #SELECT * FROM directors
      #INNER JOIN directed_movies
      #on directors.id = directed_movies.director_id
      #WHERE movies.id = directors.movie_id

    else
      puts "Please follow the commands"
    end
  end
end

#DO NOT CALL RUN in here.
def run
  # list_commands
  # welcome
end
#
#
# puts "Thanks for using mini-IMDB"
