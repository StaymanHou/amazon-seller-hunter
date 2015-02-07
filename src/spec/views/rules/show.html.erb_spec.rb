require 'rails_helper'

RSpec.describe "rules/show", :type => :view do
  before(:each) do
    @rule = assign(:rule, Rule.create!(
      :name => "Name",
      :enabled => false,
      :settings => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
