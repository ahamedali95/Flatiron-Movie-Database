class CreateDirectorTable < ActiveRecord::Migration[5.1]
  def change
    create_table :directors do |t|
      t.string :name
    end
  end
end
