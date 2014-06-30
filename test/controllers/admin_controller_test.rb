require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get costos_otros" do
    get :costos_otros
    assert_response :success
  end

  test "should get usuarios" do
    get :usuarios
    assert_response :success
  end

end
