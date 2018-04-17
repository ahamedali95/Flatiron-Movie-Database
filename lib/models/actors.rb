class Actor < ActiveRecord::Base
  has_many :casts
  has_many :movies, through: :casts

end
