require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :school_id => 1,
      :team_id => 1,
      :email => "MyString",
      :gender => "MyString",
      :github => "MyString",
      :tshirt_size => "MyString",
      :cell_phone => "MyString",
      :linkedin => "MyString",
      :dietary_restrictions => "MyString",
      :previous_experience => "MyText",
      :essay => "MyText"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_first_name[name=?]", "user[first_name]"

      assert_select "input#user_last_name[name=?]", "user[last_name]"

      assert_select "input#user_school_id[name=?]", "user[school_id]"

      assert_select "input#user_team_id[name=?]", "user[team_id]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_gender[name=?]", "user[gender]"

      assert_select "input#user_github[name=?]", "user[github]"

      assert_select "input#user_tshirt_size[name=?]", "user[tshirt_size]"

      assert_select "input#user_cell_phone[name=?]", "user[cell_phone]"

      assert_select "input#user_linkedin[name=?]", "user[linkedin]"

      assert_select "input#user_dietary_restrictions[name=?]", "user[dietary_restrictions]"

      assert_select "textarea#user_previous_experience[name=?]", "user[previous_experience]"

      assert_select "textarea#user_essay[name=?]", "user[essay]"
    end
  end
end
