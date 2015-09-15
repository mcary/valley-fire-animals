class Report < ActiveRecord::Base
  validates :report_type, :summary, :reporter_name, :reporter_contact_info,
    presence: true

  validates :summary, length: { maximum: 40 }
end
