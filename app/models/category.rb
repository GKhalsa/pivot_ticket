class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :events
  has_many :tickets, through: :events

  def self.find_by_name(params)
    find_by(name: params[:name]) || not_found
  end
end
