class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :venue
  has_many :ticket_tags
  has_many :tags, through: :ticket_tags
  validates :price,         presence: true

  enum status: %w(active retired)

  def self.search(search)
    where("ticket_tags.word IN ?", "%#{search}%")
    self.find_each do |ticket|
      tags.include?(search)
    end
  end

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
