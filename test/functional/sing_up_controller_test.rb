require 'test_helper'

class SingUpControllerTest < ActionController::TestCase
  test "should get singup" do
    get :singup
    assert_response :success
  end

  test "should get singin" do
    get :singin
    assert_response :success
  end

end
