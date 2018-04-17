# Director.create("james madison")
# #comment
require "pry"
require "rest-client"
require "json"


movies = ["Batman", "Superman", "Spiderman", "The Godfather", "Up",
  "The Lion King", "Prisoners", "The Dark Knight Rises", "Avatar", "Iron Man"]


array.each do |film|

  r = RestClient.get("http://www.omdbapi.com/?t=#{film}&apikey=485b50f7")
  movie = JSON.parse(r)
  title = movie["Title"]
  year = movie["Year"]
  rated = movie["Rated"]
  released = movie["Released"]
  genre = movie["Genre"]
  plot = movie["Plot"]
  imdb_rating = movie["imdbRating"]
  box_office = movie["BoxOffice"]
  production = movie["Production"]
  binding.pry
end



binding.pry
#hash["posts"][0]["thread"]["site"]
"hello"
