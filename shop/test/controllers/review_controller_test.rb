require "test_helper"

class ReviewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get review_index_url
    assert_response :success
  end

  test "should get show" do
    get review_show_url
    assert_response :success
  end

  test "should get create" do
    get review_create_url
    assert_response :success
  end

  test "should get update" do
    get review_update_url
    assert_response :success
  end

  test "should get destroy" do
    get review_destroy_url
    assert_response :success
  end
end
