require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RulesHelper. For example:
#
# describe RulesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AmazonHelper, :type => :helper do
  describe '#build_seller_product_url(seller_id, isbn)' do
    it 'returns "http://www.amazon.com/dp/#{isbn}/ref=lh_ni_t?ie=UTF8&psc=1&smid=#{seller_id}"' do
      expect(helper.build_seller_product_url('AGLPMRINU0Q3T', '1449335837')).to eq 'http://www.amazon.com/dp/1449335837/ref=lh_ni_t?ie=UTF8&psc=1&smid=AGLPMRINU0Q3T'
    end
  end
end
