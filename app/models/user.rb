class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
  belongs_to :venue
  has_many :user_roles
  has_many :roles, through: :user_roles
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

  def platform_admin?
    # roles.exists?(name: "platform_admin")
    roles.include?(Role.find_by(name: "platform_admin"))
  end

  def venue_admin?
    # roles.exists?(name: "venue_admin")
    roles.include?(Role.find_by(name: "venue_admin"))
  end

  def registered_user?
    # roles.exists?(name: "registered_user")
    roles.include?(Role.find_by(name: "registered_user"))
  end
end
