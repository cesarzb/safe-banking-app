require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  def self.test_order
    :alpha
  end


  setup do
    @first_user = User.create!(email: "secondfirst@example.com",
                                      password: "password",
                                      code: "22223333444455556666777788881234",
                                    )
    @first_user.confirm!
  end

  test "should show Sign Out for logged in user" do
    log_in_user(@first_user)
    visit root_path
    assert_text "Sign Out"
  end

  test "should show Sign in and Sign up for not logged in user" do
    visit root_path
    assert_text "Sign in\nSign up\nWelcome in our bank!"
  end

  test "shouldn't show Sign up and Sign in on login page" do
    visit login_path
    assert_text "Home page\nEmail\nPassword\nRemember me\nSign Up"
  end

  test "shouldn't show Sign up and Sign in on sign up page" do
    visit sign_up_path
    assert_no_text "Sign Up"
    assert_no_text "Sign In"
  end

  private

  def log_in_user(user)
    visit login_path
    fill_in "user[email]", with: @first_user.email, wait: 10
    fill_in "user[password]", with: @first_user.password
    click_on "Sign In"
    visit root_path
  end
end
