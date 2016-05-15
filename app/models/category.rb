class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :events
  has_many :tickets, through: :events
end
