require 'test_helper'

class TravelRequestsControllerTest < ActionController::TestCase
  setup do
    @travel_request = travel_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_request" do
    assert_difference('TravelRequest.count') do
      post :create, travel_request: { cant_pasaj_sol: @travel_request.cant_pasaj_sol, com_dest_sol: @travel_request.com_dest_sol, com_orig_sol: @travel_request.com_orig_sol, dir_dest_sol: @travel_request.dir_dest_sol, dir_orig_sol: @travel_request.dir_orig_sol, est_sol: @travel_request.est_sol, fecha_crea_sol: @travel_request.fecha_crea_sol, fecha_serv_sol: @travel_request.fecha_serv_sol, run_cli: @travel_request.run_cli }
    end

    assert_redirected_to travel_request_path(assigns(:travel_request))
  end

  test "should show travel_request" do
    get :show, id: @travel_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travel_request
    assert_response :success
  end

  test "should update travel_request" do
    patch :update, id: @travel_request, travel_request: { cant_pasaj_sol: @travel_request.cant_pasaj_sol, com_dest_sol: @travel_request.com_dest_sol, com_orig_sol: @travel_request.com_orig_sol, dir_dest_sol: @travel_request.dir_dest_sol, dir_orig_sol: @travel_request.dir_orig_sol, est_sol: @travel_request.est_sol, fecha_crea_sol: @travel_request.fecha_crea_sol, fecha_serv_sol: @travel_request.fecha_serv_sol, run_cli: @travel_request.run_cli }
    assert_redirected_to travel_request_path(assigns(:travel_request))
  end

  test "should destroy travel_request" do
    assert_difference('TravelRequest.count', -1) do
      delete :destroy, id: @travel_request
    end

    assert_redirected_to travel_requests_path
  end
end
