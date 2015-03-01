# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rule.create(
  name: 'low_price_n_shipping_fee_rule',
  enabled: true,
  settings: {} # the values must be string
)

Rule.create(
  name: 'positive_must_larger_than_rule',
  enabled: true,
  settings: { 'larger_than': '0.9' } # the values must be string
)

Rule.create(
  name: 'total_ratings_must_larger_than_rule',
  enabled: true,
  settings: { 'larger_than': '100' } # the values must be string
)

Rule.create(
  name: 'must_in_stock_rule',
  enabled: true,
  settings: {} # the values must be string
)
