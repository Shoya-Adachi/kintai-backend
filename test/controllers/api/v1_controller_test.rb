require "test_helper"

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get attendancePosts" do
    get api_v1_attendancePosts_url
    assert_response :success
  end
end
