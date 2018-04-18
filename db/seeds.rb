# Director.create("james madison")
# #comment
require_relative "../config/environment.rb"
require "pry"
require "rest-client"
require "json"


array = ["Batman", "Superman", "Spider-man", "The Godfather", "Up",
  "The Lion King", "Prisoners", "The Dark Knight Rises", "Avatar", "Iron Man","Nightmare Before Christmas", "Alice in wonderland","Jurassic Park", "Jurassic World", "Batman Returns", "Spider-Man 2", "Ultimate Spider-Man","Iron-man","Iron-man 2", "Iron-man 3", "Spider-Man 3", "The Lost World: Jurassic Park", "Jurassic Park III"]

array.each do |film|j
  r = RestClient.get("http://www.omdbapi.com/?t=#{film}&apikey=485b50f7")
  movie = JSON.parse(r)
  title = movie["Title"]
  year = movie["Year"]
  rated = movie["Rated"]
  released = movie["Released"]
  genre = movie["Genre"]
  director = movie["Director"].split(",").first
  plot = movie["Plot"]
  rating = movie["imdbRating"]
  box_office = movie["BoxOffice"]
  production = movie["Production"]

  d = Director.find_or_create_by(name: director)
  m = Movie.find_or_create_by(title: title, year: year, rated: rated, released: released, genre: genre, plot: plot, rating: rating, box_office: box_office, production: production)

  dm_join = DirectedMovie.find_or_create_by(director_id: d, movie_id: m)
  actors = movie["Actors"].split(",")
    actors.each do |name|
      a = Actor.find_or_create_by(name: name)
      am_join = Cast.find_or_create_by(actor_id: a.id, movie_id: m.id)
    end
  dm_join = DirectedMovie.find_or_create_by(director_id: d.id, movie_id: m.id)

end


# binding.pry

#hash["posts"][0]["thread"]["site"]
puts "hello"
