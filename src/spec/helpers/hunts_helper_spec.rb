require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HuntsHelper. For example:
#
# describe HuntsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HuntsHelper, :type => :helper do
  let(:hunt) { FactoryGirl.create(:hunt) }
  let(:failed_hunt) { FactoryGirl.create(:hunt, isbn: '1449357016', condition: 1, status: 3, result: '{"error_message": "Can not find any seller meets our criteria"}') }
  let(:succeeded_hunt) { FactoryGirl.create(:hunt, isbn: '1449357016', condition: 1, status: 2, result: '{"seller_name": "pbshop", "product_url": "http://www.amazon.com/gp/product/1449335837/ref=ox_sc_sfl_title_1?ie=UTF8&psc=1&smid=AGLPMRINU0Q3T"}') }
  let(:invalid_result_hunt) { FactoryGirl.create(:hunt, status: 2, result: '') }

  describe '#display_hunt_result(hunt[, :brief])' do
    it 'returns empty string if the hunt is pending' do
      expect(helper.display_hunt_result(hunt)).to eq ''
    end

    it 'raises error if hunt_result is not a json string' do
      expect { helper.display_hunt_result(invalid_result_hunt) }.to raise_error
    end

    it 'returns the error_message string if the hunt failed' do
      expect(helper.display_hunt_result(failed_hunt)).to eq 'Can not find any seller meets our criteria'
    end

    it 'returns the <a target="_blank" href="?">seller_name</a> string if the hunt succeeded' do
      expect(helper.display_hunt_result(succeeded_hunt)).to eq '<a target="_blank" href="http://www.amazon.com/gp/product/1449335837/ref=ox_sc_sfl_title_1?ie=UTF8&amp;psc=1&amp;smid=AGLPMRINU0Q3T">pbshop</a>'
    end
  end

  describe '#display_hunt_result(hunt, :detail)' do
    it 'returns the error_message string with the preceeding label if the hunt failed' do
      expect(helper.display_hunt_result(failed_hunt, :detail)).to eq 'Error Message: Can not find any seller meets our criteria'
    end

    it 'returns the <a href="?">seller_name</a> string if the hunt succeeded' do
      expect(helper.display_hunt_result(succeeded_hunt, :detail)).to eq 'Seller Name: pbshop Product Url: http://www.amazon.com/gp/product/1449335837/ref=ox_sc_sfl_title_1?ie=UTF8&psc=1&smid=AGLPMRINU0Q3T'
    end
  end
end
