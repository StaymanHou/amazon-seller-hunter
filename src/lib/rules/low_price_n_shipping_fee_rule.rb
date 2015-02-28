class LowPriceNShippingFeeRule < RuleProto
  def score(seller)
    return seller.price + seller.shipping_fee if seller.free_shipping_over.nil?
    return seller.price if seller.price > seller.free_shipping_over
    seller.price + seller.shipping_fee
  end
end