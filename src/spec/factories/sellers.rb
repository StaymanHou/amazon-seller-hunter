FactoryGirl.define do
  sequence :id do |n|
    n.to_s
  end

  factory :seller do
    name 'default_seller'
    id
    price 15
    shipping_fee 3
    prime false
    free_shipping_over nil
    rate 0.9
    total_ratings 10_000
    in_stock true
    ships_from 'IN, United States'
    score 100
    initialize_with { new(name, id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from) }
  end
end
