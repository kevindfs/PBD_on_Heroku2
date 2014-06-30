require 'test_helper'

class KilometersPricesControllerTest < ActionController::TestCase
  setup do
    @kilometers_price = kilometers_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kilometers_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kilometers_price" do
    assert_difference('KilometersPrice.count') do
      post :create, kilometers_price: { estado_val_km: @kilometers_price.estado_val_km, fin_val_km: @kilometers_price.fin_val_km, ini_val_km: @kilometers_price.ini_val_km, val_km: @kilometers_price.val_km }
    end

    assert_redirected_to kilometers_price_path(assigns(:kilometers_price))
  end

  test "should show kilometers_price" do
    get :show, id: @kilometers_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kilometers_price
    assert_response :success
  end

  test "should update kilometers_price" do
    patch :update, id: @kilometers_price, kilometers_price: { estado_val_km: @kilometers_price.estado_val_km, fin_val_km: @kilometers_price.fin_val_km, ini_val_km: @kilometers_price.ini_val_km, val_km: @kilometers_price.val_km }
    assert_redirected_to kilometers_price_path(assigns(:kilometers_price))
  end

  test "should destroy kilometers_price" do
    assert_difference('KilometersPrice.count', -1) do
      delete :destroy, id: @kilometers_price
    end

    assert_redirected_to kilometers_prices_path
  end
end
