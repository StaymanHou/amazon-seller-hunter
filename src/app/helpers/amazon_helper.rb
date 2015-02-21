module AmazonHelper
  def build_seller_product_url(seller_id, isbn)
    "http://www.amazon.com/dp/#{isbn}/ref=lh_ni_t?ie=UTF8&psc=1&smid=#{seller_id}"
  end
end
