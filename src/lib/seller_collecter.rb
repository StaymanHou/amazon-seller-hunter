require 'rest-client'
include AmazonHelper

module SellerCollecter
  class SellerCollecterError < StandardError
  end

  def self.collect(isbn: nil, condition: nil)
    amazon_product_list_url = build_product_list_url(isbn, condition)
    begin
      tries ||= 10
      page = RestClient.get amazon_product_list_url
    rescue RestClient::ServiceUnavailable => e
      sleep 1
      tries -= 1
      if tries > 0
        retry
      else
        fail SellerCollecterError, 'can not get the product list page'
      end
    end
  end
end