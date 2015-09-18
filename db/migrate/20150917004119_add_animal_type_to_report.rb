class AddAnimalTypeToReport < ActiveRecord::Migration
  def change
    add_reference :reports, :animal_type, index: true, foreign_key: true
  end
end
