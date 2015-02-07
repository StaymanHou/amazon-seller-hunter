require 'rails_helper'

RSpec.describe "rules/index", :type => :view do
  before(:each) do
    assign(:rules, [
      Rule.create!(
        :name => "Name",
        :enabled => false,
        :settings => ""
      ),
      Rule.create!(
        :name => "Name",
        :enabled => false,
        :settings => ""
      )
    ])
  end

  it "renders a list of rules" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
