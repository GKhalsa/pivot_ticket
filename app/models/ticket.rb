class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :category
  belongs_to :venue
  validates :price,                 presence: true
  validates :seat_location,         presence: true
  validates :seat_location,         uniqueness: { scope: :event_id,
   message: "that ticket has already been posted for sale" }

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

end
