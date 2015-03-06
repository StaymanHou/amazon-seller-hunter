require 'rest-client'
require 'nokogiri'
include AmazonHelper

module SellerCollecter
  class SellerCollecterError < StandardError
  end

  module SellerParser
    def self.parse(seller_html_element)
      flag_seller_is_amazon = seller_html_element.xpath('./div[3]/p/img').count > 0
      name = flag_seller_is_amazon ? 'amazon.com' : seller_html_element.xpath('./div[3]/p[1]/span/a').first.text
      id = flag_seller_is_amazon ? 'ATVPDKIKX0DER' : seller_html_element.xpath('./div[3]/p[1]/span/a').first['href'].split('=').last
      price = seller_html_element.xpath('./div[1]/span').first.text.strip[1..-1].to_f
      prime = !seller_html_element.xpath('./div[1]/span[contains(@class, "supersaver")]').empty?
      shipping_fee = prime ? 3.99 : seller_html_element.xpath('./div[1]/p/span/span[1]').first.text.strip[1..-1].to_f
      free_shipping_over = nil
      rate = flag_seller_is_amazon ? 1 : seller_html_element.xpath('./div[3]/p[2]/a').first.text.split('%').first.to_f/100
      total_ratings = flag_seller_is_amazon ? Float::INFINITY : /\((\d+(?:,\d+)*) (?:rating|total ratings)\)/.match(seller_html_element.xpath('./div[3]/p[2]').first.text)[1].split(',').join('').to_i
      in_stock = seller_html_element.xpath('./div[4]').first.text.include? 'In Stock'
      if flag_seller_is_amazon
        ships_from = 'United States'
      else
        m = /Ships from (.*?)\./.match(seller_html_element.xpath('./div[4]').first.text)
        if m
          ships_from = m[1]
        else
          ships_from = ''
        end
      end
      Seller.new(name, id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from)
    end
  end

  def self.collect(isbn: nil, condition: nil)
    amazon_product_list_url = build_product_list_url(isbn, condition)
    begin
      tries ||= 10
      page_html = RestClient.get amazon_product_list_url
    rescue RestClient::ServiceUnavailable
      sleep 1
      tries -= 1
      if tries > 0
        retry
      else
        fail SellerCollecterError, 'can not get the product list page'
      end
    end
    page = Nokogiri::HTML(page_html)
    seller_html_elements = page.css('html>body>div>div>div>div>div>div.olpOffer')
    seller_html_elements.map{ |seller_html_element| SellerParser::parse(seller_html_element) }
  end
end