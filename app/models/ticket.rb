class Ticket < ActiveRecord::Base

  validates :price,         presence: true
  # has_attached_file :file
  # has_attached_file :avatar,
  # default_url: "https://s3.amazonaws.com/digital-destination/missing_image.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  enum status: %w(active retired)

  def self.all_by_state
    all.order(:status)
  end

  def self.all_by_id
    all.order(:id)
  end
end
