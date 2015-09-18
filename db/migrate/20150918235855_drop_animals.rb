class DropAnimals < ActiveRecord::Migration
  def change
    # We already have animal_types
    drop_table :animals
  end
end
