require "test_helper"

class StaticpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get terms" do
    get staticpages_terms_url
    assert_response :success
  end

  test "should get privacy" do
    get staticpages_privacy_url
    assert_response :success
  end
end
