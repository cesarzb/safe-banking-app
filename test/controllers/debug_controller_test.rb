require "test_helper"

class DebugControllerTest < ActionDispatch::IntegrationTest
  test "should get env_variables" do
    get debug_env_variables_url
    assert_response :success
  end
end
