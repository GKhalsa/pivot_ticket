class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles

  def self.business_admin
    find_by(name: "business_admin")
  end
end
