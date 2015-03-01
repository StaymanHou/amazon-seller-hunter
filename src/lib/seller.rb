class Seller
  include Comparable
  attr_accessor :name, :id, :price, :shipping_fee, :prime, :free_shipping_over, :rate, :total_ratings, :in_stock, :ships_from, :score

  def initialize(name, id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from)
    @name = name
    @id = id
    @price = price
    @shipping_fee = shipping_fee
    @prime = prime
    @free_shipping_over = free_shipping_over
    @rate = rate
    @total_ratings = total_ratings
    @in_stock = in_stock
    @ships_from = ships_from
    @score = 100
  end

  def <=>(other)
    other.score <=> @score
  end
end
