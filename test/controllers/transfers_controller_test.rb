require "test_helper"
require 'benchmark'

class TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @first_user = User.create!(email: "fi3r2dfst@example.com",
      password: "password",
      code: "11112222333344445555661277778884",
    )
    @second_user = User.create!(email: "secosdfend@example.com",
          password: "password",
          code: "22223333444455556666743788889199",
        )
    @first_user.confirm!
    @second_user.confirm!
    @transfer_data = {amount: 1000, code: "33334443455566667777888799990000", title: "som title" }
  end

  test "should create transfer" do
    time_taken = Benchmark.realtime do
      (0..50).each do
        post transfers_url, params: { transfer:
                                      { amount: @transfer_data[:amount],
                                        receiver_id: @second_user.id,
                                        sender_id: @first_user.id,
                                        title: @transfer_data[:title],
                                        receiver_code: @second_user.code,
                                        sender_code: @first_user.code } }
      end
    end
    puts "Czas do wykonania 50 przelewów: #{time_taken} sekund"
  end

  test "should create transfer" do
    time_taken = Benchmark.realtime do
      (0..50).each do
        get transfers_url
      end
    end
    puts "Czas do przeglądania 50 przelewów: #{time_taken} sekund"
  end
end
