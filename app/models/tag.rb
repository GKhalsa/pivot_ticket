class Tag < ActiveRecord::Base
  has_many :ticket_tags
  has_many :tickets, through: :ticket_tags

  def self.search(search)
    tag = self.find_by(word: search)
    if tag
      tag.tickets
    end
  end

  def self.new_tags(tag_string)
    tags = self.parse_tags(tag_string)
    tags.map do |tag|
      self.find_or_create_by(word: tag)
    end
  end

  def self.parse_tags(string)
    string.split(",").map do |tag|
      tag.lstrip
    end
  end
end
