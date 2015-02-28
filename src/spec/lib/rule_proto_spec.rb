require 'rails_helper'

RSpec.describe RuleProto do
  let(:settings) { { larger_than: '100' } }

  describe "#new(settings)" do
    it "creates a rule without error and set @settings" do
      my_rule = RuleProto.new(settings)
      expect(my_rule.instance_variable_get(:@settings)).to eq(settings)
    end
  end

  describe "#filter(seller)" do
    it "returns false by default. means don't filter the seller by default" do
      my_rule = RuleProto.new(settings)
      expect(my_rule.filter(nil)).to eq false
    end
  end

  describe "#score(seller)" do
    it "returns 1 by default. means don't increase or decrease the seller score" do
      my_rule = RuleProto.new(settings)
      expect(my_rule.score(nil)).to eq 1
    end
  end
end
