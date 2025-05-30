require "test_helper"

class Api::V1::AttendancePostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_attendance_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_attendance_posts_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_attendance_posts_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_attendance_posts_update_url
    assert_response :success
  end
end
