class AddReuniterFieldsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reuniter_is_reporter, :boolean
    add_column :reports, :reuniter_name, :string
    add_column :reports, :reuniter_email, :string
    add_column :reports, :reunited_at, :datetime
    add_column :reports, :reuniter_comment, :text
  end
end
