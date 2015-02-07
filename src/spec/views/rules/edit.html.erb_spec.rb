require 'rails_helper'

RSpec.describe "rules/edit", :type => :view do
  before(:each) do
    @rule = assign(:rule, FactoryGirl.create(:rule))
  end

  it "renders the edit rule form" do
    render

    assert_select "form[action=?][method=?]", rule_path(@rule), "post" do

      assert_select "input#rule_name[name=?][disabled=disabled]", "rule[name]"

      assert_select "input#rule_enabled[name=?]", "rule[enabled]"

      assert_select "input#rule_settings[name=?]", "rule[settings]"
    end
  end
end
