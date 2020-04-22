require 'test_helper'

class PromoCreationTest < ActionDispatch::IntegrationTest
  test "Access to mispromos without authenticated user" do
    get mispromos_path
    assert_redirected_to new_user_session_path
  end

  def setup
    @david = User.create(email: "david@mail.com", password: Devise::Encryptor.digest(User, "helloworld"))
  end

end
