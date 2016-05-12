class RemoveColumnImagePathFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :image_path
  end
end
