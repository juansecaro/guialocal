require 'test_helper'

class Superadmin::PromosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_promos_index_url
    assert_response :success
  end

  test "should get new" do
    get superadmin_promos_new_url
    assert_response :success
  end

  test "should get create" do
    get superadmin_promos_create_url
    assert_response :success
  end

  test "should get show" do
    get superadmin_promos_show_url
    assert_response :success
  end

  test "should get edit" do
    get superadmin_promos_edit_url
    assert_response :success
  end

  test "should get update" do
    get superadmin_promos_update_url
    assert_response :success
  end

  test "should get destroy" do
    get superadmin_promos_destroy_url
    assert_response :success
  end

end
