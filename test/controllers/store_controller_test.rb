require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success

    assert_select "nav a", minimum: 4
    assert_select "main ul li", 3
    assert_select "h2", "The Pragmatic Programmer"
    assert_select "div", /\$[,\d]+\.\d\d/
  end

  test "should get index in Spanish" do
    get store_index_url(locale: "es")
    assert_response :success
    assert_select "h1", "Su Catálogo de Pragmatic"
    assert_select "div", /\$US [.\d]+,\d\d/
  end
end
