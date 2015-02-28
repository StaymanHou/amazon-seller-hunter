require 'rails_helper'

RSpec.describe Seller do
  describe "#new(name, id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from)" do
    let(:name) { 'stayman' }
    let(:id) { 'AGLPMRINU0Q3F' }
    let(:price) { 14.71 }
    let(:shipping_fee) { 3.99 }
    let(:prime) { false }
    let(:free_shipping_over) { 35 }
    let(:rate) { 0.9 }
    let(:total_ratings) { 290_602 }
    let(:in_stock) { true }
    let(:ships_from) { 'IN, United States' }

    it "initiates a new object and set the proper attributes" do
      seller = Seller.new(name, id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from)
      expect(seller.name).to eq name
      expect(seller.id).to eq id
      expect(seller.price).to eq price
      expect(seller.shipping_fee).to eq shipping_fee
      expect(seller.prime).to eq prime
      expect(seller.free_shipping_over).to eq free_shipping_over
      expect(seller.rate).to eq rate
      expect(seller.total_ratings).to eq total_ratings
      expect(seller.in_stock).to eq in_stock
      expect(seller.ships_from).to eq ships_from
      expect(seller.score).to eq 100
    end
  end
end
