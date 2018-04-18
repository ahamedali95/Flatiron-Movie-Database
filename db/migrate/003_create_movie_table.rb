class CreateMovieTable < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :rated
      t.integer :released
      t.string :genre
      t.text   :plot
      t.string :rating
      t.string :box_office
      t.string :production
    end
  end
end
