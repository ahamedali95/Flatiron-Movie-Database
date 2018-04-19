class Director < ActiveRecord::Base
  has_many :directed_movie
  has_many :movies, through: :directed_movie

end
