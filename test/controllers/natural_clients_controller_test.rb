require 'test_helper'

class NaturalClientsControllerTest < ActionController::TestCase
  setup do
    @natural_client = natural_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:natural_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create natural_client" do
    assert_difference('NaturalClient.count') do
      post :create, natural_client: { run_cli: @natural_client.run_cli }
    end

    assert_redirected_to natural_client_path(assigns(:natural_client))
  end

  test "should show natural_client" do
    get :show, id: @natural_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @natural_client
    assert_response :success
  end

  test "should update natural_client" do
    patch :update, id: @natural_client, natural_client: { run_cli: @natural_client.run_cli }
    assert_redirected_to natural_client_path(assigns(:natural_client))
  end

  test "should destroy natural_client" do
    assert_difference('NaturalClient.count', -1) do
      delete :destroy, id: @natural_client
    end

    assert_redirected_to natural_clients_path
  end
end
