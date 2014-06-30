require 'test_helper'

class AssignedsControllerTest < ActionController::TestCase
  setup do
    @assigned = assigneds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assigneds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assigned" do
    assert_difference('Assigned.count') do
      post :create, assigned: { fin_assigned: @assigned.fin_assigned, id_veh: @assigned.id_veh, ini_assigned: @assigned.ini_assigned, run_driv: @assigned.run_driv }
    end

    assert_redirected_to assigned_path(assigns(:assigned))
  end

  test "should show assigned" do
    get :show, id: @assigned
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assigned
    assert_response :success
  end

  test "should update assigned" do
    patch :update, id: @assigned, assigned: { fin_assigned: @assigned.fin_assigned, id_veh: @assigned.id_veh, ini_assigned: @assigned.ini_assigned, run_driv: @assigned.run_driv }
    assert_redirected_to assigned_path(assigns(:assigned))
  end

  test "should destroy assigned" do
    assert_difference('Assigned.count', -1) do
      delete :destroy, id: @assigned
    end

    assert_redirected_to assigneds_path
  end
end
