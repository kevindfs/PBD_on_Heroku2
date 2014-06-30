require 'test_helper'

class StateHistoriesControllerTest < ActionController::TestCase
  setup do
    @state_history = state_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:state_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create state_history" do
    assert_difference('StateHistory.count') do
      post :create, state_history: { id_stat: @state_history.id_stat, id_trav: @state_history.id_trav }
    end

    assert_redirected_to state_history_path(assigns(:state_history))
  end

  test "should show state_history" do
    get :show, id: @state_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @state_history
    assert_response :success
  end

  test "should update state_history" do
    patch :update, id: @state_history, state_history: { id_stat: @state_history.id_stat, id_trav: @state_history.id_trav }
    assert_redirected_to state_history_path(assigns(:state_history))
  end

  test "should destroy state_history" do
    assert_difference('StateHistory.count', -1) do
      delete :destroy, id: @state_history
    end

    assert_redirected_to state_histories_path
  end
end
