class Report < ActiveRecord::Base
  has_attached_file :photo,
    styles: {
      thumb: "140x140#",
      medium: "500x500>",
    },
    :convert_options => {
      :medium => "-strip -quality 90 -interlace Plane",
    }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator,
    attributes: :photo,
    less_than: 10.megabytes

  validates :report_type, :summary, :reporter_name, :reporter_contact_info,
    presence: true

  validates :summary, length: { maximum: 40 }
end
