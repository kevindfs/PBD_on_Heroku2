require 'test_helper'

class OfferVehiclesControllerTest < ActionController::TestCase
  setup do
    @offer_vehicle = offer_vehicles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_vehicles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_vehicle" do
    assert_difference('OfferVehicle.count') do
      post :create, offer_vehicle: { est_oferta_veh: @offer_vehicle.est_oferta_veh, id_block: @offer_vehicle.id_block, run_driv: @offer_vehicle.run_driv }
    end

    assert_redirected_to offer_vehicle_path(assigns(:offer_vehicle))
  end

  test "should show offer_vehicle" do
    get :show, id: @offer_vehicle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer_vehicle
    assert_response :success
  end

  test "should update offer_vehicle" do
    patch :update, id: @offer_vehicle, offer_vehicle: { est_oferta_veh: @offer_vehicle.est_oferta_veh, id_block: @offer_vehicle.id_block, run_driv: @offer_vehicle.run_driv }
    assert_redirected_to offer_vehicle_path(assigns(:offer_vehicle))
  end

  test "should destroy offer_vehicle" do
    assert_difference('OfferVehicle.count', -1) do
      delete :destroy, id: @offer_vehicle
    end

    assert_redirected_to offer_vehicles_path
  end
end
