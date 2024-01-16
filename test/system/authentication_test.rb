require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  def self.test_order
    :alpha
  end


  setup do
    # @first_user = users(:one)
    @first_user = User.create!(email: "firs43t@example.com",
                                      password: "password",
                                      code: "11112222333344445557666677778888",
                                    )
    @user_data = { email: "seconrwed@example.com",
                                      password: "password",
                                      code: "22223373444455556666777788889999",
    }
    @first_user.confirm!
    @transfer_data = {amount: 10, code: "33334444555566667777888899990000" }
    # @first_transfer = transfers(:one)
  end

  test "An example test" do
    puts "\nAuthentication Tests:\n"
    visit root_path
  end

  ### NOT AUTHORIZED
  test "login should have email password and remember me" do
    visit login_path
    assert_text "Email"
    assert_text "Password"
    assert_text "Remember me"
  end

  test "sign up should have email password and password confirmation" do
    visit sign_up_path
    assert_text "Email"
    assert_text "Password"
    assert_text "Password confirmation"
  end

  test "login should redirect to transfers" do
    visit login_path
    fill_in "user[email]", with: @first_user.email
    fill_in "user[password]", with: @first_user.password
    click_on "Sign In", wait: 10
    assert_text "Transfers" || assert_text("Remember me")
  end

  test "sign up should redirect to transfers" do
    visit sign_up_path
    fill_in "user[email]", with: @user_data[:email]
    fill_in "user[password]", with: @user_data[:password]
    fill_in "user[password_confirmation]", with: @user_data[:password]
    click_on "Sign Up", wait: 10
    assert_text "Sign in\nSign up\nWelcome in our bank!"
  end

  test "sign out should redirect to home page" do
    log_in_user(@first_user)
    visit root_path
    click_on "Sign Out", wait: 10
    assert_text "Welcome in our bank!"
  end


  ### AUTHORIZED
  test "login should redirect logged in user to transfers" do
    log_in_user(@first_user)
    visit login_path
    assert_text "Sign Out\nTransfers\nNew transfer"
  end

  test "sign up should redirect logged in user to transfers" do
    log_in_user(@first_user)
    visit sign_up_path
    assert_text "Transfers"
  end

  # private

  def log_in_user(user)
    visit login_path
    fill_in "user[email]", with: @first_user.email, wait: 10
    fill_in "user[password]", with: @first_user.password
    click_on "Sign In"
    visit root_path
  end
end
