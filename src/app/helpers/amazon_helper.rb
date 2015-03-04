module AmazonHelper
  def build_seller_product_url(seller_id, isbn)
    "http://www.amazon.com/dp/#{isbn}/ref=lh_ni_t?ie=UTF8&psc=1&smid=#{seller_id}"
  end

  def build_product_list_url(isbn, condition)
    "http://www.amazon.com/gp/offer-listing/#{isbn}/ref=olp_tab_new?ie=UTF8&condition=#{condition.to_s.split('_')[0]}"
  end
end
