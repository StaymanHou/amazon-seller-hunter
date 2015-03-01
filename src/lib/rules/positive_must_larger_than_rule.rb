class PositiveMustLargerThanRule < RuleProto
  def filter(seller)
    seller.rate <= @settings['larger_than']
  end
end