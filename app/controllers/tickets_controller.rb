class TicketsController < ApplicationController
  include TicketsHelper
  before_action :set_ticket, only: [:edit, :update, :activate, :de_activate, :qr]
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @categories = Category.all
    @tickets = Tag.search(params[:search])
    @venues = Venue.all
  end

  def qr
    @venues = Venue.all
    @categories = Category.all
    if @ticket.event.date > Date.today
      render :show
    elsif @ticket.status == "not_valid"
      flash.now[:error] = "This ticket has already been used"
      render :show
    else
      @ticket.status = "not_valid"
      flash.now[:notice] = "Ticket has been processed."
      render :show
    end
  end

  def de_activate
    change_status(@ticket, 1, "de-activated")
    redirect_to dashboard_path
  end

  def activate
    change_status(@ticket, 0, "posted for sale")
    redirect_to dashboard_path
  end

  def new
    @categories = Category.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = current_user.id
    tags = Tag.new_tags(params[:ticket][:tags])
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
