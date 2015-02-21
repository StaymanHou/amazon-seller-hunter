class Hunter
  include Sidekiq::Worker
  include AmazonHelper

  def perform(hunt_id)
    hunt = Hunt.find(hunt_id)
    hunt.update(status: :working)
    begin
      sellers = SellerCollecter.collect(isbn: hunt.isbn, condition: hunt.condition)
      best_seller = RuleEngine.pick_best(sellers)
    rescue Exception => e
      hunt.update(status: :failed, result: %Q{{"error_message": "#{e.message}"}})
      return
    end
    product_url = build_seller_product_url(best_seller.id, hunt.isbn)
    hunt.update(status: :finished, result: %Q{{"seller_name": "#{best_seller.name}", "product_url": "#{product_url}"}})
  end
end
