require 'test_helper'

class TravelsControllerTest < ActionController::TestCase
  setup do
    @travel = travels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel" do
    assert_difference('Travel.count') do
      post :create, travel: { dist_est_via: @travel.dist_est_via, hora_ini_via: @travel.hora_ini_via, id_trav_req: @travel.id_trav_req, run_driv: @travel.run_driv, tiemp_est_via: @travel.tiemp_est_via, val_via: @travel.val_via }
    end

    assert_redirected_to travel_path(assigns(:travel))
  end

  test "should show travel" do
    get :show, id: @travel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travel
    assert_response :success
  end

  test "should update travel" do
    patch :update, id: @travel, travel: { dist_est_via: @travel.dist_est_via, hora_ini_via: @travel.hora_ini_via, id_trav_req: @travel.id_trav_req, run_driv: @travel.run_driv, tiemp_est_via: @travel.tiemp_est_via, val_via: @travel.val_via }
    assert_redirected_to travel_path(assigns(:travel))
  end

  test "should destroy travel" do
    assert_difference('Travel.count', -1) do
      delete :destroy, id: @travel
    end

    assert_redirected_to travels_path
  end
end
