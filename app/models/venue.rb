class Venue < ActiveRecord::Base
  has_many :events
  has_many :tickets, through: :events
end
