require 'test_helper'

class OperadorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get solicitudes" do
    get :solicitudes
    assert_response :success
  end

  test "should get disp_conductor" do
    get :disp_conductor
    assert_response :success
  end

  test "should get usuarios_reg" do
    get :usuarios_reg
    assert_response :success
  end

end
