class TicketsController < ApplicationController
  def index
    @categories = Category.all
    @tickets = Tag.search(params[:search])
    @venues = Venue.all
  end

  def show

  end
end
