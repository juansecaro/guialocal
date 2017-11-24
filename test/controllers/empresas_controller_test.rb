require 'test_helper'

class EmpresasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @empresa = empresas(:one)
  end

  test "should get index" do
    get empresas_url
    assert_response :success
  end

  test "should get new" do
    get new_empresa_url
    assert_response :success
  end

  test "should create empresa" do
    assert_difference('Empresa.count') do
      post empresas_url, params: { empresa: { description: @empresa.description, direction: @empresa.direction, email: @empresa.email, imgLogo: @empresa.imgLogo, imgLogoAlt: @empresa.imgLogoAlt, mapLat: @empresa.mapLat, mapLon: @empresa.mapLon, name: @empresa.name, offer_id: @empresa.offer_id, photo_id: @empresa.photo_id, schedule: @empresa.schedule, tag_id: @empresa.tag_id, tel: @empresa.tel, user_id: @empresa.user_id, video: @empresa.video, web: @empresa.web } }
    end

    assert_redirected_to empresa_url(Empresa.last)
  end

  test "should show empresa" do
    get empresa_url(@empresa)
    assert_response :success
  end

  test "should get edit" do
    get edit_empresa_url(@empresa)
    assert_response :success
  end

  test "should update empresa" do
    patch empresa_url(@empresa), params: { empresa: { description: @empresa.description, direction: @empresa.direction, email: @empresa.email, imgLogo: @empresa.imgLogo, imgLogoAlt: @empresa.imgLogoAlt, mapLat: @empresa.mapLat, mapLon: @empresa.mapLon, name: @empresa.name, offer_id: @empresa.offer_id, photo_id: @empresa.photo_id, schedule: @empresa.schedule, tag_id: @empresa.tag_id, tel: @empresa.tel, user_id: @empresa.user_id, video: @empresa.video, web: @empresa.web } }
    assert_redirected_to empresa_url(@empresa)
  end

  test "should destroy empresa" do
    assert_difference('Empresa.count', -1) do
      delete empresa_url(@empresa)
    end

    assert_redirected_to empresas_url
  end
end
