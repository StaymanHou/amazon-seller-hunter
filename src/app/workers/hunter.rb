class Hunter
  include Sidekiq::Worker
  include AmazonHelper

  def perform(hunt_id)
    setup_work(hunt_id)
    find_best_seller
    return unless (defined? @best_seller) && @best_seller
    finish_work
  end

  private

  def setup_work(hunt_id)
    @hunt = Hunt.find(hunt_id)
    @hunt.update(status: :working)
  end

  def find_best_seller
    sellers = SellerCollecter.collect(isbn: @hunt.isbn, condition: @hunt.condition)
    @best_seller = RuleEngine.pick_best(sellers)
  rescue StandardError => e
    @hunt.update(status: :failed, result: %({"error_message": "#{e.message}"}))
  end

  def finish_work
    product_url = build_seller_product_url(@best_seller.id, @hunt.isbn)
    @hunt.update(status: :finished, result: %({"seller_name": "#{@best_seller.name}", "product_url": "#{product_url}"}))
  end
end
