require 'rails_helper'

RSpec.describe "rules/index", :type => :view do
  before(:each) do
    assign(:rules, [
      FactoryGirl.create(:rule, name: 'Name', settings: {}),
      FactoryGirl.create(:rule)
    ])
  end

  it "renders a list of rules" do
    render
    assert_select "tr>td", :text => "default".to_s, :count => 1
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => true.to_s, :count => 2
    assert_select "tr>td", :text => '{"larger_than"=>100}'.to_s, :count => 1
    assert_select "tr>td", :text => "{}".to_s, :count => 1
  end
end
