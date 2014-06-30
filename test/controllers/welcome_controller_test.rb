require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get reserva" do
    get :reserva
    assert_response :success
  end

  test "should get qs" do
    get :qs
    assert_response :success
  end

  test "should get tarifas" do
    get :tarifas
    assert_response :success
  end

  test "should get contacto" do
    get :contacto
    assert_response :success
  end

end
