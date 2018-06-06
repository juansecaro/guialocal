require 'test_helper'

class Superadmin::CreditosControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get superadmin_creditos_edit_url
    assert_response :success
  end

  test "should get update" do
    get superadmin_creditos_update_url
    assert_response :success
  end

end
