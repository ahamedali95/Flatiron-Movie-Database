require 'pry'
require 'json'
require 'rest-client'

puts "Enter a movie name: "
input = gets.chomp

response = RestClient.get("http://www.omdbapi.com/?t=#{input}&apikey=485b50f7")
movie = JSON.parse(response)

#movie["posts"][0]["thread"]["site"]

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
"hello"
