require 'test_helper'

class Superadmin::ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_application_index_url
    assert_response :success
  end

end
