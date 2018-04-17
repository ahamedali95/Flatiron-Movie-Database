# Director.create("james madison")
# #comment
require "pry"
require "rest-client"
require "json"


movies = ["Batman", "Superman", "Spiderman", "The Godfather", "The Dark Knight Rises",
  "The Dark Knight", "Prisoners", "The Dark Knight Rises", "Avatar", "Iron Man"]


array.each do |movie|
  response = RestClient.get("http://www.omdbapi.com/?t=#{movie.split(" ").join("+")}&apikey=485b50f7")
  hash = JSON.parse(response)
end



binding.pry
#hash["posts"][0]["thread"]["site"]
"hello"
