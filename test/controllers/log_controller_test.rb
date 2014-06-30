require 'test_helper'

class LogControllerTest < ActionController::TestCase
  test "should get iniciar" do
    get :iniciar
    assert_response :success
  end

  test "should get registrar" do
    get :registrar
    assert_response :success
  end

end
