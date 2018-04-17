class DirectedMovie < ActiveRecord::Base
  belongs_to :director
  belongs_to :movie

end
