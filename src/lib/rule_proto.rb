class RuleProto
  def initialize(settings)
    @settings = settings
  end

  def filter(_seller)
    # if not override, it will never filter the seller
    false
  end

  def score(_seller)
    # if not override, it will always keep the same score of the seller
    1
  end
end
