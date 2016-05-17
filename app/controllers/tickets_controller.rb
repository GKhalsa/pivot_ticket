class TicketsController < ApplicationController
  include TicketsHelper
  before_action :set_ticket, only: [:edit, :update, :activate, :de_activate]
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @categories = Category.all
    @tickets = Tag.search(params[:search])
    @venues = Venue.all
  end

  def show

  end

  def de_activate
    change_status(@ticket, 1, "de-activated")
    redirect_to dashboard_path
  end

  def activate
    change_status(@ticket, 0, "posted for sale")
    redirect_to dashboard_path
  end

  def my_tickets
    @categories = Category.all
    @tickets = Ticket.where(user_id: current_user.id)
    render :my_tickets_index
  end


  def new
    @categories = Category.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = current_user.id
    tags = @ticket.new_tags(params[:ticket][:tags])
    if @ticket.save
      @ticket.tags = tags
      flash[:notice] = "Ticket successfully posted."
      redirect_to dashboard_path
    else
      flash[:notice] = @ticket.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    unless @ticket.owner == current_user
      render file: "public/404"
      flash[:error] = "Not Authorized"
    end
  end

  def update
    @ticket.update(ticket_params)
    redirect_to my_tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:price, :avatar, :category_id, :event_id, :seat_location)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
