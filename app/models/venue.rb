class Venue < ActiveRecord::Base
  before_create :generate_slug
  has_many :users
  has_many :events
  has_many :tickets, through: :events

  enum status: %w(pending active inactive)


  def generate_slug
    self.slug = self.name.parameterize
  end

  def first_admin
    "first admin email link"
  end

  def alerts?
    false
  end

end
