class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :venue
  has_many :tickets

  has_attached_file :event_image,
  default_url: "https://s3.amazonaws.com/digital-destination/missing_image.png"
  validates_attachment_content_type :event_image, :content_type => /\Aimage\/.*\Z/

  def average_ticket_price
    "$#{tickets.average(:price).round(2)}"
  end

  def this_week?
    Range.new(Date.today, Date.today+7).include?(date)
  end

  def date_string
    date.strftime('%a, %b %e')
  end

  def type
    category.name.downcase == "sports" ? "Game" : "Show"
  end

  def card_title
    "#{performing.gsub(", ", " and ")} on #{date_string}"
  end
end
