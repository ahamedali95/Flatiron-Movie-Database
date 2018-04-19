class Movie < ActiveRecord::Base
  has_many :movies_directed
  has_many :casts #:actors
  has_many :actors, through: :casts #:casts, through: :actors
  has_many :directors, through: :movies_directed

  def print_info
    puts

  end

end
