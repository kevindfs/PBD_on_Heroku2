require 'test_helper'

class DriversLicenseAlertsControllerTest < ActionController::TestCase
  setup do
    @drivers_license_alert = drivers_license_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drivers_license_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drivers_license_alert" do
    assert_difference('DriversLicenseAlert.count') do
      post :create, drivers_license_alert: { plant_alert_licenc: @drivers_license_alert.plant_alert_licenc }
    end

    assert_redirected_to drivers_license_alert_path(assigns(:drivers_license_alert))
  end

  test "should show drivers_license_alert" do
    get :show, id: @drivers_license_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drivers_license_alert
    assert_response :success
  end

  test "should update drivers_license_alert" do
    patch :update, id: @drivers_license_alert, drivers_license_alert: { plant_alert_licenc: @drivers_license_alert.plant_alert_licenc }
    assert_redirected_to drivers_license_alert_path(assigns(:drivers_license_alert))
  end

  test "should destroy drivers_license_alert" do
    assert_difference('DriversLicenseAlert.count', -1) do
      delete :destroy, id: @drivers_license_alert
    end

    assert_redirected_to drivers_license_alerts_path
  end
end
