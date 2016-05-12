class RemoveColumnAvatarFromTicket < ActiveRecord::Migration
  def change
    remove_attachment :tickets, :avatar
  end
end
