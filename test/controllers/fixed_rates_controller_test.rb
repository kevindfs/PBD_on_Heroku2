require 'test_helper'

class FixedRatesControllerTest < ActionController::TestCase
  setup do
    @fixed_rate = fixed_rates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fixed_rates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fixed_rate" do
    assert_difference('FixedRate.count') do
      post :create, fixed_rate: { costo_tar: @fixed_rate.costo_tar, dest_tar: @fixed_rate.dest_tar, ori_tar: @fixed_rate.ori_tar }
    end

    assert_redirected_to fixed_rate_path(assigns(:fixed_rate))
  end

  test "should show fixed_rate" do
    get :show, id: @fixed_rate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fixed_rate
    assert_response :success
  end

  test "should update fixed_rate" do
    patch :update, id: @fixed_rate, fixed_rate: { costo_tar: @fixed_rate.costo_tar, dest_tar: @fixed_rate.dest_tar, ori_tar: @fixed_rate.ori_tar }
    assert_redirected_to fixed_rate_path(assigns(:fixed_rate))
  end

  test "should destroy fixed_rate" do
    assert_difference('FixedRate.count', -1) do
      delete :destroy, id: @fixed_rate
    end

    assert_redirected_to fixed_rates_path
  end
end
