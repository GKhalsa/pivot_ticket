class CartTickets < SimpleDelegator
  attr_reader :quantity, :item

  def initialize(item, quantity)
    @item = item
    @quantity = quantity
    super(@item)
  end

  def price
    (item.price * quantity).round(2)
  end
end
