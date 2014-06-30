require 'test_helper'

class EnterpriseClientsControllerTest < ActionController::TestCase
  setup do
    @enterprise_client = enterprise_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enterprise_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enterprise_client" do
    assert_difference('EnterpriseClient.count') do
      post :create, enterprise_client: { run_cli: @enterprise_client.run_cli, rut_ent: @enterprise_client.rut_ent }
    end

    assert_redirected_to enterprise_client_path(assigns(:enterprise_client))
  end

  test "should show enterprise_client" do
    get :show, id: @enterprise_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enterprise_client
    assert_response :success
  end

  test "should update enterprise_client" do
    patch :update, id: @enterprise_client, enterprise_client: { run_cli: @enterprise_client.run_cli, rut_ent: @enterprise_client.rut_ent }
    assert_redirected_to enterprise_client_path(assigns(:enterprise_client))
  end

  test "should destroy enterprise_client" do
    assert_difference('EnterpriseClient.count', -1) do
      delete :destroy, id: @enterprise_client
    end

    assert_redirected_to enterprise_clients_path
  end
end
