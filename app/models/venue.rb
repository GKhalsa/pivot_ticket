class Venue < ActiveRecord::Base
  before_create :generate_slug
  has_many :users
  has_many :events
  has_many :tickets, through: :events
  has_many :users

  has_attached_file :image,
  default_url: "https://s3.amazonaws.com/digital-destination/missing_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  enum status: %w(pending active inactive)

  def generate_slug
    self.slug = self.name.parameterize
  end

  def alerts?
    false
  end

  def self.find_by_name(params)
    find_by(slug: params[:venue])
  end
end
