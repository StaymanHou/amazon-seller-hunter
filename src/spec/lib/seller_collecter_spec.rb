require 'rails_helper'

RSpec.describe SellerCollecter do
  describe '::collect(isbn: isbn, condition: condition)' do
    before do
      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0135157861/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 503, :body => "", :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0135157862/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.read("spec/html_files/0135157862_NEW_1.html"), :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0751515736/ref=olp_tab_new?condition=used&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.read("spec/html_files/0751515736_USED_1.html"), :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0907871496/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.read("spec/html_files/0907871496_NEW_1.html"), :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/14165532277/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => File.read("spec/html_files/14165532277_NEW_1.html"), :headers => {})
    end

    it 'raises error if amazon returns 503 for 10 times' do
      expect{ SellerCollecter.collect(isbn: '0135157861', condition: :new_book) }.to raise_error(SellerCollecter::SellerCollecterError)
    end

    it 'asdfiowief' do
      page = SellerCollecter.collect(isbn: '0135157862', condition: :new_book)
      expect(page).to eq(File.read("spec/html_files/0135157862_NEW_1.html"))
    end
  end
end
