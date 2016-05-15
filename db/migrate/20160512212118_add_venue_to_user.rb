class AddVenueToUser < ActiveRecord::Migration
  def change
    add_reference :users, :venue, index: true, foreign_key: true
  end
end
