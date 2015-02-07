json.array!(@rules) do |rule|
  json.extract! rule, :id, :name, :enabled, :settings
  json.url rule_url(rule, format: :json)
end
