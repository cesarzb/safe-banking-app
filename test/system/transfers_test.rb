require "application_system_test_case"

class TransfersTest < ApplicationSystemTestCase
  def self.test_order
    :alpha
  end


  setup do
    # @first_user = users(:one)
    @first_user = User.create!(email: "firsedfst@example.com",
                                      password: "password",
                                      code: "11112222333344445555666677778884",
                                    )
    @second_user = User.create!(email: "secogrend@example.com",
                                      password: "password",
                                      code: "22223333444455556666777788889199",
                                    )
    @first_user.confirm!
    @second_user.confirm!
    @transfer_data = {amount: 10, code: "33334444555566667777888799990000", title: "some title" }
    @first_transfer = Transfer.create!(sender_code: @first_user.code,
                                        receiver_code: @second_user.code,
                                        sender_id: @first_user.id,
                                        receiver_id: @second_user.id,
                                        title: "Money for Danny",
                                        amount: 1000)
    visit root_path
  end

  test "An example test" do
    puts "\nTransfers Tests:\n"
    visit root_path
  end

  ### NOT AUTHORIZED
  test "visiting the transfers index unauthorized" do
    visit transfers_url
    assert_text "Home page\nEmail\nPassword\nRemember me\nSign Up"
  end

  ### AUTHORIZED
  test "visiting the transfers index authorized" do
    log_in_user(@first_user)
    visit transfers_url
    assert_text "Transfers"
  end

  test "should create transfer for correct data" do
    log_in_user(@first_user)
    visit transfers_url
    if page.has_selector?("a", text: "New transfer") || page.has_selector?("button", text: "New transfer")
      click_on "New transfer", wait: 10
    else
      return
    end

    fill_in "transfer[amount]", with: @transfer_data[:amount]
    fill_in "transfer[receiver_code]", with: @second_user.code
    fill_in "transfer[title]", with: @transfer_data[:title]
    click_on "Create Transfer", wait: 10

    assert_text "Sign Out\nTransfer was successfully created.\nTitle: some title\nAmount: 10.0\nSender: 11112222333344445555666677778884\nReceiver: 22223333444455556666777788889199\nBack to transfers"
    click_on "Back"
  end

  test "shouldn't create transfer without amount" do
    log_in_user(@first_user)
    visit transfers_url
    click_on "New transfer", wait: 10

    fill_in "transfer[receiver_code]", with: @second_user.code
    fill_in "transfer[title]", with: @transfer_data[:title]
    click_on "Create Transfer", wait: 10

    assert_text "Sign Out\nNew transfer\n1 error prohibited this transfer from being saved:\nAmount can't be blank\nTitle\nAmount\nReceiver code\n\nBack to transfers"
    click_on "Back"
  end

  test "shouldn't create transfer without receiver code" do
    log_in_user(@first_user)
    visit transfers_url
    click_on "New transfer", wait: 10

    fill_in "transfer[amount]", with: @transfer_data[:amount]
    fill_in "transfer[title]", with: @transfer_data[:title]
    click_on "Create Transfer", wait: 10

    assert_text "Sign Out\nNew transfer\n1 error prohibited this transfer from being saved:\nReceiver must exist\nTitle\nAmount\nReceiver code\n\nBack to transfers"
    click_on "Back"
  end

  test "shouldn't create transfer without title" do
    log_in_user(@first_user)
    visit transfers_url
    click_on "New transfer", wait: 10

    fill_in "transfer[amount]", with: @transfer_data[:amount]
    fill_in "transfer[receiver_code]", with: @second_user.code
    click_on "Create Transfer", wait: 10

    assert_text "Sign Out\nNew transfer\n1 error prohibited this transfer from being saved:\nTitle can't be blank\nTitle\nAmount\nReceiver code\n\nBack to transfers"
    click_on "Back"
  end

  test "should show transfer for logged in user" do
    log_in_user(@first_user)
    visit transfer_path(@first_transfer)
    assert_text "Money for Danny"
  end

  test "shouldn't show transfer for not logged in user" do
    transfer_path(@first_transfer)
    assert_text "Sign in\nSign up\nWelcome in our bank!"
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
