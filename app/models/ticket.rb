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

  def parse_tags(string)
    string.split(",").map do |tag|
      tag.lstrip
    end
  end

  def new_tags(tag_string)
    tags = parse_tags(tag_string)
    tags.map do |tag|
      Tag.find_or_create_by(word: tag)
    end
  end

end
