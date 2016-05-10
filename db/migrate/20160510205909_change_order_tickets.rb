class ChangeOrderTickets < ActiveRecord::Migration
  def change
    remove_reference :order_tickets, :item
    add_reference :order_tickets, :ticket
  end
end
