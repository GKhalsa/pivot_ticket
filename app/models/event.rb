class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :tickets

  has_attached_file :event_image,
  default_url: "https://s3.amazonaws.com/digital-destination/missing_image.png"
  validates_attachment_content_type :event_image, :content_type => /\Aimage\/.*\Z/
end
