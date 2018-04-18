class CreateMovieTable < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :rated
      t.string :released
      t.string :genre
      t.text   :plot
      t.float :rating
      t.string :box_office
      t.string :production
    end
  end
end
