class Movie < ActiveRecord::Base
  has_many :directed_movie
  has_many :casts #:actors
  has_many :actors, through: :casts #:casts, through: :actors
  has_many :directors, through: :directed_movie

end
