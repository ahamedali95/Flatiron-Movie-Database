class CreateActorTable < ActiveRecord::Migration[4.2]
  def change
    create_table :actors do |t|
      t.string :name
    end
  end
end
