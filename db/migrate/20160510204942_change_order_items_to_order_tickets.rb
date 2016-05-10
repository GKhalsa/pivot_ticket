class ChangeOrderItemsToOrderTickets < ActiveRecord::Migration
  def change
    rename_table :order_items, :order_tickets
  end
end
