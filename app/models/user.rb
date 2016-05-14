class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
  has_many  :orders
  has_many  :order_tickets, through: :orders
  has_many  :tickets, through: :order_tickets

  enum role: %w(default admin)

  def self.o_auth_find_or_create_by(auth_hash)
    user = where(
      email: auth_hash[:info][:email],
      name: auth_hash[:info][:nickname],
    ).first
    user = create_user_from(auth_hash) if user.nil?
    user
  end

  def self.create_user_from(auth_hash)
    create(
      email: auth_hash[:info][:email],
      name: auth_hash[:info][:nickname],
      password: rand(1..10_000).to_s
    )
  end

  def tickets
    Ticket.where(user_id: self.id)
  end
end
