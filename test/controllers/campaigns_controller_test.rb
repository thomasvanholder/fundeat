require 'test_helper'

class CampaignsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get campaigns_new_url
    assert_response :success
  end

  test "should get create" do
    get campaigns_create_url
    assert_response :success
  end

  test "should get edit" do
    get campaigns_edit_url
    assert_response :success
  end

  test "should get update" do
    get campaigns_update_url
    assert_response :success
  end

  test "should get show" do
    get campaigns_show_url
    assert_response :success
  end

  test "should get index" do
    get campaigns_index_url
    assert_response :success
  end

end
