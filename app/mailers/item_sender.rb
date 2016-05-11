class ItemSender < ApplicationMailer
  def send_order(user, order)
    @order = order
    @user  = user
    @tickets = @order.tickets
    mail(to: @user.email, subject: "Here is your Order!")
  end
end
