class Report < ActiveRecord::Base
  has_attached_file :photo,
    styles: {
      thumb: "140x140#",
      medium: "500x500>",
    },
    :convert_options => {
      :medium => "-strip -quality 90 -interlace Plane",
    }

  belongs_to :animal_type
  delegate :name, to: :animal_type, prefix: true, allow_nil: true

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator,
    attributes: :photo,
    less_than: 10.megabytes

  validates :report_type, :summary, :reporter_name, :reporter_contact_info, :animal_type,
    presence: true

  validates :summary, length: { maximum: 40 }

  validates :reuniter_name, :reuniter_email, presence: true,
    unless: proc {|r|
      (r.changed & %w{reunited reuniter_email reuniter_name}).empty?
    }
end
