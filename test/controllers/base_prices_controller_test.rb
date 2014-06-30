require 'test_helper'

class BasePricesControllerTest < ActionController::TestCase
  setup do
    @base_price = base_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_price" do
    assert_difference('BasePrice.count') do
      post :create, base_price: { estado_val_base: @base_price.estado_val_base, fin_val_base: @base_price.fin_val_base, ini_val_base: @base_price.ini_val_base, val_base: @base_price.val_base }
    end

    assert_redirected_to base_price_path(assigns(:base_price))
  end

  test "should show base_price" do
    get :show, id: @base_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @base_price
    assert_response :success
  end

  test "should update base_price" do
    patch :update, id: @base_price, base_price: { estado_val_base: @base_price.estado_val_base, fin_val_base: @base_price.fin_val_base, ini_val_base: @base_price.ini_val_base, val_base: @base_price.val_base }
    assert_redirected_to base_price_path(assigns(:base_price))
  end

  test "should destroy base_price" do
    assert_difference('BasePrice.count', -1) do
      delete :destroy, id: @base_price
    end

    assert_redirected_to base_prices_path
  end
end
