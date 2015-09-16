class CreateAnimalFosterHomes < ActiveRecord::Migration
  def change
    create_table :animal_foster_homes do |t|
      t.integer :foster_home_id
      t.integer :animal_id

      t.timestamps null: false
    end
  end
end
