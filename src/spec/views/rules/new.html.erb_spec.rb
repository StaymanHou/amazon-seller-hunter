require 'rails_helper'

RSpec.describe "rules/new", :type => :view do
  before(:each) do
    assign(:rule, Rule.new(
      :name => "MyString",
      :enabled => false,
      :settings => ""
    ))
  end

  it "renders new rule form" do
    render

    assert_select "form[action=?][method=?]", rules_path, "post" do

      assert_select "input#rule_name[name=?]", "rule[name]"

      assert_select "input#rule_enabled[name=?]", "rule[enabled]"

      assert_select "input#rule_settings[name=?]", "rule[settings]"
    end
  end
end
