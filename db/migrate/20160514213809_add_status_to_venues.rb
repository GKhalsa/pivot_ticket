class AddStatusToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :status, :integer, default: 0
  end
end
