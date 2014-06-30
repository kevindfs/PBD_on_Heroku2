require 'test_helper'

class OwnerCommissionsControllerTest < ActionController::TestCase
  setup do
    @owner_commission = owner_commissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:owner_commissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create owner_commission" do
    assert_difference('OwnerCommission.count') do
      post :create, owner_commission: { fin_comi_prop: @owner_commission.fin_comi_prop, ini_comi_prop: @owner_commission.ini_comi_prop, porcent_comi_prop: @owner_commission.porcent_comi_prop }
    end

    assert_redirected_to owner_commission_path(assigns(:owner_commission))
  end

  test "should show owner_commission" do
    get :show, id: @owner_commission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @owner_commission
    assert_response :success
  end

  test "should update owner_commission" do
    patch :update, id: @owner_commission, owner_commission: { fin_comi_prop: @owner_commission.fin_comi_prop, ini_comi_prop: @owner_commission.ini_comi_prop, porcent_comi_prop: @owner_commission.porcent_comi_prop }
    assert_redirected_to owner_commission_path(assigns(:owner_commission))
  end

  test "should destroy owner_commission" do
    assert_difference('OwnerCommission.count', -1) do
      delete :destroy, id: @owner_commission
    end

    assert_redirected_to owner_commissions_path
  end
end
