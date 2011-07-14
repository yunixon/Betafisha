require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get singup" do
    get :new
    assert_response :success
  end

  test "should get singin" do
    get :singin
    assert_response :success
  end

end
