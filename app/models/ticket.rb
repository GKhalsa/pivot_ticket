class Ticket < ActiveRecord::Base
  belongs_to :event
  has_many :orders
  belongs_to :user
  validates :price,         presence: true


  enum status: %w(active retired)

  def self.all_by_state
    all.order(:status)
  end

  def self.all_by_id
    all.order(:id)
  end

  def event_title
    event.title
  end

  def event_performing
    event.performing
  end

  def venue_name
    event.venue.name
  end

  def event_date
    event.date
  end

  def owner
    self.user
  end

end
