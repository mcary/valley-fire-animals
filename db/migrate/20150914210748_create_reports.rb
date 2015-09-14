class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :summary
      t.text :description
      t.string :report_type
      t.string :reporter_name
      t.text :reporter_contact_info

      t.timestamps null: false
    end
  end
end
