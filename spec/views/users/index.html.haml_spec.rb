require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
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
      ),
      User.create!(
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
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Github".to_s, :count => 2
    assert_select "tr>td", :text => "Tshirt Size".to_s, :count => 2
    assert_select "tr>td", :text => "Cell Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Linkedin".to_s, :count => 2
    assert_select "tr>td", :text => "Dietary Restrictions".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
