require 'test_helper'

class ClienteControllerTest < ActionController::TestCase
  test "should get estado" do
    get :estado
    assert_response :success
  end

  test "should get solicitud" do
    get :solicitud
    assert_response :success
  end

  test "should get condiciones" do
    get :condiciones
    assert_response :success
  end

end
