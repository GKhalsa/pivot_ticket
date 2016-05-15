class Venue < ActiveRecord::Base
  before_create :generate_slug

  has_many :events
  has_many :tickets, through: :events
  has_many :users

  has_attached_file :image,
  default_url: "https://s3.amazonaws.com/digital-destination/missing_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  def generate_slug
    self.slug = self.name.parameterize
  end

  def pending?
    !approved
  end

end
