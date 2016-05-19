class Ticket < ActiveRecord::Base
  belongs_to :event
  has_many :orders
  belongs_to :user
  belongs_to :category
  belongs_to :venue
  has_many :ticket_tags
  has_many :tags, through: :ticket_tags
  validates :price,                 presence: true
  validates :seat_location,         presence: true
  validates :seat_location,         uniqueness: { scope: :event_id,
   message: "that ticket has already been posted for sale" }

  enum status: %w(active inactive not_valid)

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

  def appropriate_photo
    event.category.name.downcase
  end
end
