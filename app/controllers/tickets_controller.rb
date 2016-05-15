class TicketsController < ApplicationController
  before_action :set_ticket, only: [:retire, :activate, :edit, :update]
  before_action :require_login, only: [:new, :create, :edit, :update]

  def index
    @categories = Category.all
    @tickets = Ticket.all_by_state
    @venues = Venue.all
  end

  def show

  end

  def my_tickets
    @categories = Category.all
    @tickets = Ticket.where(user_id: current_user.id)
    render :my_tickets_index
  end

  def retire
    @ticket.retired!
    redirect_to tickets_path
  end

  def activate
    @ticket.active!
    redirect_to tickets_path
  end

  def new
    @categories = Category.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = current_user.id
    if @ticket.save
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
