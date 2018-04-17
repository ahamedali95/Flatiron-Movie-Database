# Director.create("james madison")
# #comment
require_relative "../config/environment.rb"
require "pry"
require "rest-client"
require "json"


array = ["Batman", "Superman", "Spiderman", "The Godfather", "Up",
  "The Lion King", "Prisoners", "The Dark Knight Rises", "Avatar", "Iron Man"]

array.each do |film|
  r = RestClient.get("http://www.omdbapi.com/?t=#{film}&apikey=485b50f7")
  movie = JSON.parse(r)
  title = movie["Title"]
  year = movie["Year"]
  rated = movie["Rated"]
  released = movie["Released"]
  genre = movie["Genre"]
  director = movie["Director"]
  plot = movie["Plot"]
  rating = movie["imdbRating"]
  box_office = movie["BoxOffice"]
  production = movie["Production"]
  Director.find_or_create_by(name: director)
  Movie.find_or_create_by(title: title, year: year, rated: rated, released: released, genre: genre, plot: plot, rating: rating, box_office: box_office, production: production)
end

# binding.pry

#hash["posts"][0]["thread"]["site"]
puts "hello"
