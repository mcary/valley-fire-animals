class AddConfirmationFieldsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reunion_confirmed, :boolean
    add_column :reports, :reunion_confirmed_by, :string
    add_column :reports, :reunion_confirmed_at, :datetime
    add_column :reports, :reunion_confirmation_notes, :text
  end
end
