class Rule
  include Mongoid::Document
  field :name, type: String
  field :enabled, type: Mongoid::Boolean, default: true
  field :settings, type: Hash, default: {}
  validates :name, uniqueness: true
  validates :enabled, inclusion: [true, false]
end
