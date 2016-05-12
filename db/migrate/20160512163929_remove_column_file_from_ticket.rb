class RemoveColumnFileFromTicket < ActiveRecord::Migration
  def change
    remove_attachment :tickets, :file
  end
end
