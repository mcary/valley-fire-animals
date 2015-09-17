class AddReuintedToReport < ActiveRecord::Migration
  def change
    add_column :reports, :reunited, :boolean
  end
end
