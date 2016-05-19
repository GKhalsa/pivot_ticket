class ItemSender < ApplicationMailer

  def send_order(user, order)
    create_qr(order)
    @order = order
    @user  = user
    @tickets = @order.tickets
    mail(to: @user.email, subject: "Here is your Order!")
  end

  def create_qr(order)
    order.tickets.each.with_index do |ticket, i|
      code = RQRCode::QRCode.new( "#{ticket_qr_url(ticket.id)}", :size => 8, :level => :h )
      png = code.as_png(size: 300)
      attachments.inline["qr#{i}.png"] = [png]
    end
  end
end
