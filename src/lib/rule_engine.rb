module RuleEngine
  class RuleEngineError < StandardError
  end

  def self.pick_best(sellers)
    raise RuleEngineError.new('I can\'t do anything if you give me a empty array of sellers.') if sellers.empty?
    @@sellers = sellers
    set_rules
    @@rules.each do |rule|
      filter_sellers(rule)
      score_sellers(rule)
    end
    raise RuleEngineError.new('All the sellers have been filtered. Consider loose the rules.') if @@sellers.empty?
    @@sellers.min_by(&:score)
  end

  private

  def self.my_path
    File.dirname(__FILE__)
  end

  def self.set_rules
    return if (defined? @@rules) && @@rules
    @@rules = []
    rules = Rule.all
    rules.each do |rule|
      next unless rule.enabled
      require my_path + "/rules/#{rule.name}"
      rule_class_name = rule.name.camelize
      rule_class = Object.const_get(rule_class_name)
      rule_instance = rule_class.new(rule.settings)
      @@rules << rule_instance
    end
  end

  def self.filter_sellers(rule)
    @@sellers.delete_if { |seller| rule.filter(seller) }
  end

  def self.score_sellers(rule)
    @@sellers.each do |seller|
      seller.score *= rule.score(seller)
    end
  end
end