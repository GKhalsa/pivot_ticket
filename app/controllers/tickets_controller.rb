class TicketsController < ApplicationController
  def index
    @categories = Category.all
    @tickets = Ticket.all_by_state
  end
end