class AddReporterEmailToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reporter_email, :string
  end
end
