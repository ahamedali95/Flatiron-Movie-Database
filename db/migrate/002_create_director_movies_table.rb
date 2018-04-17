class CreateDirectorMovieTable < ActiveRecord::Migration[5.1]
  def change
    create_table :movies_directed do |t|
      t.integer :director_id
      t.integer :movie_id
      #comment
      #another comment
    end
  end
end
