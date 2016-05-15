class TicketsController < ApplicationController
  def index
    @categories = Category.all
    @tickets = Ticket.search(params[:search]).order("created_at DESC")
    @venues = Venue.all
    binding.pry
  end

  def show

  end
end
