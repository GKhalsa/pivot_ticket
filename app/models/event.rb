class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :venue
  has_many :tickets
  validates :date,  presence: true

  has_attached_file :event_image,
  default_url: "http://i.imgur.com/ULEPAyO.jpg"
  has_attached_file :qr_code
  validates_attachment_content_type :event_image, :content_type => /\Aimage\/.*\Z/

  def average_ticket_price
    if tickets.empty?
      "no tickets"
    else
      "$#{tickets.average(:price).round(2)}"
    end
  end

  def this_week?
    Range.new(Date.today, Date.today+7).include?(date)
  end

  def date_string
    date.strftime('%a, %b %e')
  end
end
