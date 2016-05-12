class Venue < ActiveRecord::Base
  before_create :generate_slug

  has_many :events
  has_many :tickets, through: :events


  def generate_slug
    self.slug = self.name.parameterize
  end

end
