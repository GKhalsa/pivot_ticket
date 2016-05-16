class Tag < ActiveRecord::Base
  has_many :ticket_tags
  has_many :tickets, through: :ticket_tags

  def self.search(search)
    tag = self.find_by(word: search)
    if tag
      tag.tickets
    end
  end
end
