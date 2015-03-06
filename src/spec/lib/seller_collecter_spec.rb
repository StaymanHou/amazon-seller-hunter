require 'rails_helper'

RSpec.describe SellerCollecter do
  describe '::collect(isbn: isbn, condition: condition)' do
    before do
      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0135157861/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0'}).
        to_return(:status => 503, :body => "", :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0135157862/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0'}).
        to_return(:status => 200, :body => File.read("spec/html_files/0135157862_NEW_1.html"), :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0751515736/ref=olp_tab_new?condition=used&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0'}).
        to_return(:status => 200, :body => File.read("spec/html_files/0751515736_USED_1.html"), :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/0907871496/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0'}).
        to_return(:status => 200, :body => File.read("spec/html_files/0907871496_NEW_1.html"), :headers => {})

      stub_request(:get, "http://www.amazon.com/gp/offer-listing/1416532277/ref=olp_tab_new?condition=new&ie=UTF8").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0'}).
        to_return(:status => 200, :body => File.read("spec/html_files/1416532277_NEW_1.html"), :headers => {})
    end

    it 'returns a list of sellers including amazon, out of stock, unknown ships from, ' do
      sellers = SellerCollecter.collect(isbn: '0135157862', condition: :new_book)
      amazons = sellers.select { |seller| seller.name == 'amazon.com' }
      expect(amazons.count).to eq(1)
      amazon = amazons.first
      expect(amazon.id).to eq('ATVPDKIKX0DER')
      expect(amazon.price).to eq(49.52)
      expect(amazon.shipping_fee).to eq(3.99)
      expect(amazon.prime).to eq(true)
      expect(amazon.free_shipping_over).to eq(nil)
      expect(amazon.rate).to eq(1)
      expect(amazon.total_ratings).to eq(Float::INFINITY)
      expect(amazon.in_stock).to eq(false)
      expect(amazon.ships_from).to eq('United States')

      collegebooksdirects = sellers.select { |seller| seller.name == 'collegebooksdirect' }
      expect(collegebooksdirects.count).to eq(1)
      collegebooksdirect = collegebooksdirects.first
      expect(collegebooksdirect.id).to eq('A2DIRKU079H2QT')
      expect(collegebooksdirect.price).to eq(46.38)
      expect(collegebooksdirect.shipping_fee).to eq(3.99)
      expect(collegebooksdirect.prime).to eq(false)
      expect(collegebooksdirect.rate).to eq(0.94)
      expect(collegebooksdirect.total_ratings).to eq(217514)
      expect(collegebooksdirect.in_stock).to eq(true)
      expect(collegebooksdirect.ships_from).to eq('TX, United States')

      total_books = sellers.select { |seller| seller.name == 'TOTAL BOOKS' }
      total_books = total_books.first
      expect(total_books.ships_from).to eq('')

      maria_pelagio = sellers.select { |seller| seller.name == 'Maria Pelagio' }
      maria_pelagio = maria_pelagio.first
      expect(maria_pelagio.total_ratings).to eq(1)
    end

    it 'returns a list of sellers including ships from UK' do
      sellers = SellerCollecter.collect(isbn: '0751515736', condition: :used_book)

      better_world_books_uk = sellers.select { |seller| seller.name == 'BetterWorldBooksUK' }
      better_world_books_uk = better_world_books_uk.first
      expect(better_world_books_uk.ships_from).to eq('United Kingdom')
    end

    it 'returns a list of sellers without error' do
      sellers = SellerCollecter.collect(isbn: '0907871496', condition: :new_book)

      expect(sellers.count).to eq(10)
    end

    it 'returns a list of sellers including amazon, out of stock, unknown ships from, ' do
      sellers = SellerCollecter.collect(isbn: '1416532277', condition: :new_book)

      expect(sellers.count).to eq(10)
    end

    it 'raises error if amazon returns 503 for 10 times' do
      expect{ SellerCollecter.collect(isbn: '0135157861', condition: :new_book) }.to raise_error(SellerCollecter::SellerCollecterError)
    end
  end
end
