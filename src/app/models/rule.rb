class Rule
  include Mongoid::Document
  field :name, type: String
  field :enabled, type: Mongoid::Boolean
  field :settings, type: Hash
end
