require 'rails_helper'

RSpec.describe "hunts/show", :type => :view do
  before(:each) do
    @hunt = assign(:hunt, FactoryGirl.create(:hunt))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/978-0596514273/)
    expect(rendered).to match(/new_book/)
    expect(rendered).to match(/pending/)
  end
end
