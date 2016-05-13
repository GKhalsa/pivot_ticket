class Venue < ActiveRecord::Base
  before_create :generate_slug

  has_many :events
  has_many :tickets, through: :events

  enum status: %w(pending active inactive)


  def generate_slug
    self.slug = self.name.parameterize
  end

  def admin_list
    "links to a venues admins go here"
  end

  def alerts?
    false
  end

end
