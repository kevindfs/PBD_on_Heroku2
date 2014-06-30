require 'test_helper'

class GestionUsuariosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get gestion_conductores" do
    get :gestion_conductores
    assert_response :success
  end

  test "should get gestion_empresas" do
    get :gestion_empresas
    assert_response :success
  end

  test "should get gestion_operadores" do
    get :gestion_operadores
    assert_response :success
  end

  test "should get gestion_propietarios" do
    get :gestion_propietarios
    assert_response :success
  end

end
