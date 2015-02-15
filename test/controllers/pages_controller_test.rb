require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
