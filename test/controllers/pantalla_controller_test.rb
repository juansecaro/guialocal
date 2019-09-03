require 'test_helper'

class PantallaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pantalla_index_url
    assert_response :success
  end

end
