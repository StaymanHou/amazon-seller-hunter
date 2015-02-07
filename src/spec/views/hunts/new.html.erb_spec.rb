require 'rails_helper'

RSpec.describe "hunts/new", :type => :view do
  before(:each) do
    assign(:hunt, Hunt.new(
      :isbn => "MyString",
      :condition => 1,
      :status => 1,
      :result => "MyText"
    ))
  end

  it "renders new hunt form" do
    render

    assert_select "form[action=?][method=?]", hunts_path, "post" do

      assert_select "input#hunt_isbn[name=?]", "hunt[isbn]"

      assert_select "input#hunt_condition[name=?]", "hunt[condition]"

      assert_select "input#hunt_status[name=?]", "hunt[status]"

      assert_select "textarea#hunt_result[name=?]", "hunt[result]"
    end
  end
end
