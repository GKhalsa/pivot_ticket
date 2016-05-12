class TicketsController < ApplicationController
  before_action :set_ticket, only: [:retire, :activate, :edit, :update]

  def index
    @categories = Category.all
    @tickets = Ticket.all_by_state
  end

  def retire
    @ticket.retired!
    redirect_to admin_tickets_path
  end

  def activate
    @ticket.active!
    redirect_to admin_tickets_path
  end

  def new
    @user = current_user
    binding.pry
    @categories = Category.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to tickets_path
    else
      flash[:notice] = @ticket.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    @ticket.update(ticket_params)
    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:price, :avatar, :category_id, :event_id, :seat_location)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
