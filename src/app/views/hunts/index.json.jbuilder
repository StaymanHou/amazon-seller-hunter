json.array!(@hunts) do |hunt|
  json.extract! hunt, :id, :isbn, :condition, :status, :result
  json.url hunt_url(hunt, format: :json)
end
