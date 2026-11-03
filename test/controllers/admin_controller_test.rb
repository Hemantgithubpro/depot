require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:one)
  end

  test "should get index" do
    get admin_index_url
    assert_response :success
  end
end
