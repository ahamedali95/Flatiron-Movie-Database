class CreateMoviesDirectedTable < ActiveRecord::Migration[4.2]
  def change
    create_table :movies_directed do |t|
      t.integer :director_id
      t.integer :movie_id
      #comment
      #another comment
    end
  end
end
