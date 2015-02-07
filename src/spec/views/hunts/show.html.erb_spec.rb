require 'rails_helper'

RSpec.describe "hunts/show", :type => :view do
  before(:each) do
    @hunt = assign(:hunt, Hunt.create!(
      :isbn => "Isbn",
      :condition => 1,
      :status => 2,
      :result => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Isbn/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
