require 'rails_helper'

RSpec.describe RuleEngine do
  let(:sellers) {
    [
      FactoryGirl.build(:seller, name: 'seller_1', price: 100, in_stock: true),
      FactoryGirl.build(:seller, name: 'seller_2', price: 10, in_stock: true),
      FactoryGirl.build(:seller, name: 'seller_3', price: 1, in_stock: false)
    ]
  }
  let(:rules) {
    [
      FactoryGirl.create(:rule, name: 'must_in_stock_rule', settings: {}),
      FactoryGirl.create(:rule, name: 'low_price_n_shipping_fee_rule', settings: {})
    ]
  }

  before do
    allow(Rule).to receive(:all).and_return(rules)
  end

  describe "::pick_best(sellers)" do
    it "runs rule#filter/score properly and returns the best seller" do
      best_seller = RuleEngine.pick_best(sellers)
      expect(best_seller.name).to eq 'seller_2'
    end

    it "raises error if sellers is empty" do
      expect{ RuleEngine.pick_best([]) }.to raise_error(RuleEngine::RuleEngineError)
    end

    it "raises error if there's no seller left after filters" do
      expect{ RuleEngine.pick_best([FactoryGirl.build(:seller, name: 'seller_3', price: 1, in_stock: false)]) }.to raise_error(RuleEngine::RuleEngineError)
    end
  end
end
