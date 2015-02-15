require 'rails_helper'

RSpec.describe "hunts/index", :type => :view do
  before(:each) do
    assign(:hunts, Kaminari.paginate_array([
      FactoryGirl.create(:hunt, isbn: '1449357016', condition: 1, status: 3, result: '{"error_message": "Can not find any seller meets our criteria"}'),
      FactoryGirl.create(:hunt)
    ]).page(1).per(25))
  end

  it "renders a list of hunts" do
    render
    assert_select "tr>td", :text => '978-0596514273'.to_s, :count => 1
    assert_select "tr>td", :text => '1449357016'.to_s, :count => 1
    assert_select "tr>td", :text => 'New book', :count => 1
    assert_select "tr>td", :text => 'Used book', :count => 1
    assert_select "tr>td", :text => 'Pending', :count => 1
    assert_select "tr>td", :text => 'Failed', :count => 1
    assert_select "tr>td", :text => 'Can not find any seller meets our criteria', :count => 1
  end
end
