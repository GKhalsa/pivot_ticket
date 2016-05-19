class Admin::TicketsController < Admin::BaseController
  before_action :set_ticket, only: [:retire, :de_activate, :activate, :edit, :update]
  include TicketsHelper

  def index
    @tickets = Ticket.all_by_id
  end

  def de_activate
    change_status(@ticket, 1, "de-activated")
    redirect_to admin_tickets_path
  end

  def activate
    change_status(@ticket, 0, "posted for sale")
    redirect_to admin_tickets_path
  end

  def new
    @categories = Category.all
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to admin_tickets_path
    else
      flash[:notice] = @ticket.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    @ticket.update(ticket_params)
    redirect_to admin_tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:price, :avatar, :category_id, :event_id, :seat_location)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
