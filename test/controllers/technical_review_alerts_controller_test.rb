require 'test_helper'

class TechnicalReviewAlertsControllerTest < ActionController::TestCase
  setup do
    @technical_review_alert = technical_review_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:technical_review_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create technical_review_alert" do
    assert_difference('TechnicalReviewAlert.count') do
      post :create, technical_review_alert: { plant_alert_rev_tec: @technical_review_alert.plant_alert_rev_tec }
    end

    assert_redirected_to technical_review_alert_path(assigns(:technical_review_alert))
  end

  test "should show technical_review_alert" do
    get :show, id: @technical_review_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @technical_review_alert
    assert_response :success
  end

  test "should update technical_review_alert" do
    patch :update, id: @technical_review_alert, technical_review_alert: { plant_alert_rev_tec: @technical_review_alert.plant_alert_rev_tec }
    assert_redirected_to technical_review_alert_path(assigns(:technical_review_alert))
  end

  test "should destroy technical_review_alert" do
    assert_difference('TechnicalReviewAlert.count', -1) do
      delete :destroy, id: @technical_review_alert
    end

    assert_redirected_to technical_review_alerts_path
  end
end
