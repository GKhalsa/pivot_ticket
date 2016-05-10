class Cart
  attr_accessor :contents
  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_ticket(ticket_id)
    contents[ticket_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def total
    all_tickets.inject(0) { |sum, ticket| sum + ticket.price }.round(2)
  end

  def all_tickets
    contents.map do |id, quantity|
      ticket = Ticket.find(id)
      CartTicket.new(ticket, quantity)
    end
  end

  def delete_ticket(ticket_id)
    contents.delete(ticket_id.to_s)
  end

  def update_ticket(ticket_id, quantity)
    contents[ticket_id.to_s] = quantity
  end

  def number_of_tickets
    contents.values.reduce(:+)
  end
end
