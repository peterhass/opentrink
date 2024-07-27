require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get impress" do
    get static_pages_impress_url
    assert_response :success
  end

  test "should get privacy" do
    get static_pages_privacy_url
    assert_response :success
  end
end
