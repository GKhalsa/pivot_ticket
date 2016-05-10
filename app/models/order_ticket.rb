class OrderTicket < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :order

  def total
    (quantity * ticket.price).round(2)
  end

  def status
    ticket.status
  end
end
