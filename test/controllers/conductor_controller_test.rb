require 'test_helper'

class ConductorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get calendario" do
    get :calendario
    assert_response :success
  end

end
