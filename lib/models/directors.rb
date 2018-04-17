class Director < ActiveRecord::Base
  has_many :movies_directed
  has_many :movies, through: :movies_directed

end
