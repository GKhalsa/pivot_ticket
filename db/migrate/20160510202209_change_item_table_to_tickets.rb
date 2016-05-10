class ChangeItemTableToTickets < ActiveRecord::Migration
  def change
    remove_column :items, :title
    remove_column :items, :description
    rename_column :items, :state, :status
    add_column :items, :seat_location, :string
    rename_table :items, :tickets
  end
end
