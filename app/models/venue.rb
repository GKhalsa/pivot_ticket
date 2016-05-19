class Venue < ActiveRecord::Base
  before_create :generate_slug
  geocoded_by :address
  after_validation :geocode
  has_many :users
  has_many :events
  has_many :tickets, through: :events
  has_many :users
  # validates :name, presence: true, uniqueness: true
  # validates :address, presence: true, uniqueness: true

  has_attached_file :image,
  default_url: "http://i.imgur.com/ULEPAyO.jpg"
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

  def make_user_admin
    users.first.roles << return_business_admin_role
  end

  def return_business_admin_role
    Role.find_or_create_by(name: "business_admin")
  end
end
