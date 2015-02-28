class MustInStockRule < RuleProto
  def filter(seller)
    seller.in_stock == false
  end
end