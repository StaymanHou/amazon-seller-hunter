require 'rails_helper'

RSpec.describe "hunts/index", :type => :view do
  before(:each) do
    assign(:hunts, [
      Hunt.create!(
        :isbn => "Isbn",
        :condition => 1,
        :status => 2,
        :result => "MyText"
      ),
      Hunt.create!(
        :isbn => "Isbn",
        :condition => 1,
        :status => 2,
        :result => "MyText"
      )
    ])
  end

  it "renders a list of hunts" do
    render
    assert_select "tr>td", :text => "Isbn".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
