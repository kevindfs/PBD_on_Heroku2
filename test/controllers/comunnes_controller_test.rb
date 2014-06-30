require 'test_helper'

class ComunnesControllerTest < ActionController::TestCase
  setup do
    @comunne = comunnes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comunnes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comunne" do
    assert_difference('Comunne.count') do
      post :create, comunne: { nom_comun: @comunne.nom_comun, num_comun: @comunne.num_comun }
    end

    assert_redirected_to comunne_path(assigns(:comunne))
  end

  test "should show comunne" do
    get :show, id: @comunne
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comunne
    assert_response :success
  end

  test "should update comunne" do
    patch :update, id: @comunne, comunne: { nom_comun: @comunne.nom_comun, num_comun: @comunne.num_comun }
    assert_redirected_to comunne_path(assigns(:comunne))
  end

  test "should destroy comunne" do
    assert_difference('Comunne.count', -1) do
      delete :destroy, id: @comunne
    end

    assert_redirected_to comunnes_path
  end
end
