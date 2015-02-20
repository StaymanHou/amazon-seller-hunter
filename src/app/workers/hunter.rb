class Hunter
  include Sidekiq::Worker

  def perform(hunt_id)
    puts "Hunting #{hunt_id}"
  end
end
