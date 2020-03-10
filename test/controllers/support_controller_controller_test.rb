require 'test_helper'

class SupportControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get support_controller_create_url
    assert_response :success
  end

end
