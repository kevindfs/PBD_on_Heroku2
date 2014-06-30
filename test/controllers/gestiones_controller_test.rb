require 'test_helper'

class GestionesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get gestion_moviles" do
    get :gestion_moviles
    assert_response :success
  end

  test "should get gestion_tarifas" do
    get :gestion_tarifas
    assert_response :success
  end

  test "should get gestion_informacion" do
    get :gestion_informacion
    assert_response :success
  end

  test "should get gestion_convenios" do
    get :gestion_convenios
    assert_response :success
  end

end
