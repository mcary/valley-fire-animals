class AddPhotoToReports < ActiveRecord::Migration
  def up
    add_attachment :reports, :photo
  end

  def down
    remove_attachment :reports, :photo
  end
end
