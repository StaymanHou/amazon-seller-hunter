module RuleEngine
  class RuleEngineError < StandardError
  end

  def self.pick_best(sellers)
    set_rules
  end

  private

  def self.set_rules
    @@rules = []
  end
end