require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :school_id => 1,
      :team_id => 2,
      :email => "Email",
      :gender => "Gender",
      :github => "Github",
      :tshirt_size => "Tshirt Size",
      :cell_phone => "Cell Phone",
      :linkedin => "Linkedin",
      :dietary_restrictions => "Dietary Restrictions",
      :previous_experience => "MyText",
      :essay => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Github/)
    expect(rendered).to match(/Tshirt Size/)
    expect(rendered).to match(/Cell Phone/)
    expect(rendered).to match(/Linkedin/)
    expect(rendered).to match(/Dietary Restrictions/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
