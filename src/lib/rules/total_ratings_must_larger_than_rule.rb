class TotalRatingsMustLargerThanRule < RuleProto
  def filter(seller)
    seller.total_ratings <= @settings['larger_than'].to_f
  end
end
