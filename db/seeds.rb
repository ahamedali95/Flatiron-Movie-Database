# Director.create("james madison")
# #comment
require_relative "../config/environment.rb"
require "pry"
require "rest-client"
require "json"


array = ["Batman", "Superman", "Spider-man", "The Godfather", "Up",
  "The Lion King", "Prisoners", "The Dark Knight Rises", "Avatar",
  "Iron Man","Nightmare Before Christmas", "Alice in wonderland",
  "Jurassic Park", "Jurassic World", "Batman Returns", "Spider-Man 2",
  "Ultimate Spider-Man","Iron-man","Iron-man 2", "Iron-man 3",
  "Spider-Man 3", "The Lost World: Jurassic Park", "Jurassic Park III"]
  #binding.pry

array.each do |film|
  r = RestClient.get("http://www.omdbapi.com/?t=#{film}&apikey=485b50f7")
  movie = JSON.parse(r)
  title = movie["Title"]
  year = movie["Year"].to_i
  rated = movie["Rated"]
  released = movie["Released"]
  genre = movie["Genre"]
  director = movie["Director"].split(",").first
  plot = movie["Plot"]
  #rating is a floating value but it goes in to the database as a real value
  rating = movie["imdbRating"].to_f
  !movie["BoxOffice"] == nil? ? box_office = movie["BoxOffice"] : box_office == "N/A"
  !movie["Production"] == nil? ? production = movie["Production"].gsub(/[A-Za-z]/, "") : production = "other"

  d = Director.find_or_create_by(name: director)
  m = Movie.find_or_create_by(title: title, year: year, rated: rated, released: released, genre: genre, plot: plot, rating: rating, box_office: box_office, production: production)
  directed_movie_join = DirectedMovie.find_or_create_by(director_id: d.id, movie_id: m.id)

  actors = movie["Actors"].split(", ")
    actors.each do |name|
      actor = Actor.find_or_create_by(name: name)
      cast_join = Cast.find_or_create_by(actor_id: actor.id, movie_id: m.id)
    end

end
