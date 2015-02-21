require 'rails_helper'

RSpec.describe Hunter do
  let(:hunt) { FactoryGirl.create(:hunt) }
  let(:sellers) {
    [
      instance_double('Seller', name: 'stayman', id: 'AGLPMRINU0Q3T'),
      instance_double('Seller', name: 'hou', id: 'A3G4HAIRHHDXNZ')
    ]
  }

  before do
    allow(Hunt).to receive(:find).with(hunt.id).and_return(hunt)
    allow(hunt).to receive(:update).and_return(hunt)
    allow(SellerCollecter).to receive(:collect).and_return(sellers)
    allow(RuleEngine).to receive(:pick_best).and_return(sellers.first)
  end

  describe "#perform(hunt_id)" do
    it "updates the hunt to working status" do
      Hunter.new.perform(hunt.id)
      expect(hunt).to have_received(:update).with(hash_including(status: :working))
    end

    it "invokes SellerCollecter.collect() with the isbn and condition" do
      Hunter.new.perform(hunt.id)
      expect(SellerCollecter).to have_received(:collect).with(hash_including(isbn: hunt.isbn, condition: hunt.condition))
    end

    it "updates the status to failed and save the error message if SellerCollecter raises error" do
      allow(SellerCollecter).to receive(:collect).and_raise(SellerCollecter::SellerCollecterError, 'page not found')
      Hunter.new.perform(hunt.id)
      expect(hunt).to have_received(:update).with(hash_including(status: :failed, result: '{"error_message": "page not found"}'))
    end

    it "passes the seller list collected from SellerCollecter and invokes RuleEngine.pick_best() with the list" do
      Hunter.new.perform(hunt.id)
      expect(RuleEngine).to have_received(:pick_best).with(sellers)
    end

    it "updates the status to failed and save the error message if RuleEngine raises error" do
      allow(RuleEngine).to receive(:pick_best).and_raise(RuleEngine::RuleEngineError, 'failed to load rules')
      Hunter.new.perform(hunt.id)
      expect(hunt).to have_received(:update).with(hash_including(status: :failed, result: '{"error_message": "failed to load rules"}'))
    end

    it "updates the status to finished and save seller_name & product_url" do
      Hunter.new.perform(hunt.id)
      expect(hunt).to have_received(:update).with(hash_including(status: :finished, result: %Q{{"seller_name": "#{sellers.first.name}", "product_url": "http://www.amazon.com/dp/#{hunt.isbn}/ref=lh_ni_t?ie=UTF8&psc=1&smid=#{sellers.first.id}"}}))
    end
  end
end
