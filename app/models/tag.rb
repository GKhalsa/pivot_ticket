class Tag < ActiveRecord::Base
  has_many :ticket_tags
  has_many :tickets, through: :ticket_tags

  def self.search(search)
    self.find_by(word: search).tickets
  end
end
