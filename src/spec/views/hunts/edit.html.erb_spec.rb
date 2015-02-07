require 'rails_helper'

RSpec.describe "hunts/edit", :type => :view do
  before(:each) do
    @hunt = assign(:hunt, Hunt.create!(
      :isbn => "MyString",
      :condition => 1,
      :status => 1,
      :result => "MyText"
    ))
  end

  it "renders the edit hunt form" do
    render

    assert_select "form[action=?][method=?]", hunt_path(@hunt), "post" do

      assert_select "input#hunt_isbn[name=?]", "hunt[isbn]"

      assert_select "input#hunt_condition[name=?]", "hunt[condition]"

      assert_select "input#hunt_status[name=?]", "hunt[status]"

      assert_select "textarea#hunt_result[name=?]", "hunt[result]"
    end
  end
end
