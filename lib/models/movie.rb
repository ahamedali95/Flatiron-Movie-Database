class Movie < ActiveRecord::Base
  has_many :directed_movie
  has_many :casts #:actors
  has_many :actors, through: :casts #:casts, through: :actors
  has_many :directors, through: :directed_movie


  def print_info
    puts "Title: #{self.title}"
    puts "Year: #{self.year}"
    puts "MPAA rating: #{self.rated}"
    puts "Release date: #{self.released}"
    puts "Genre: #{self.genre}"
    puts "Director: #{directors.name}"
    puts "Synopsis: #{self.plot}"
    puts "IMDB Rating: #{self.rating}"
    puts "Box office gross: #{self.box_office}"
    puts "Studio: #{self.production}"
  end

end
