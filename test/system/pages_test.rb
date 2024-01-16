require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  def self.test_order
    :alpha
  end


  setup do
    # @first_user = users(:one)
    @first_user = User.create!(email: "firstdfs@example.com",
                                      password: "password",
                                      code: "11112522333344445555666677778888",
                                    )
    @second_user = User.create!(email: "secondsfe@example.com",
                                      password: "password",
                                      code: "22221333444455556666777788889999",
                                    )
    @first_user.confirm!
    @transfer_data = {amount: 10, code: "33334424555566667777888899990000" }
    # @first_transfer = transfers(:one)
  end

  test "An example test" do
    puts "\nPages Tests:\n"
    visit root_path
  end

  ### NOT AUTHORIZED
  test "visiting the root unauthorized" do
    visit root_path
    assert_text "Welcome in our bank!"
  end

  ### AUTHORIZED
  test "visiting the root authorized" do
    log_in_user(@first_user)
    visit root_path
    assert_text "Sign in\nSign up\nWelcome in our bank!"
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
