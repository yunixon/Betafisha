require 'test_helper'

class SiteTopNavigationControllerTest < ActionController::TestCase
  test "should get betting" do
    get :betting
    assert_response :success
  end

  test "should get free_bets" do
    get :free_bets
    assert_response :success
  end

  test "should get in_play" do
    get :in_play
    assert_response :success
  end

  test "should get tipping" do
    get :tipping
    assert_response :success
  end

  test "should get gaming" do
    get :gaming
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

end
