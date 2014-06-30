require 'test_helper'

class TechnicalReviewExpirationsControllerTest < ActionController::TestCase
  setup do
    @technical_review_expiration = technical_review_expirations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:technical_review_expirations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create technical_review_expiration" do
    assert_difference('TechnicalReviewExpiration.count') do
      post :create, technical_review_expiration: { mes_venc_rev_tec: @technical_review_expiration.mes_venc_rev_tec, num_venc_rev_tec: @technical_review_expiration.num_venc_rev_tec }
    end

    assert_redirected_to technical_review_expiration_path(assigns(:technical_review_expiration))
  end

  test "should show technical_review_expiration" do
    get :show, id: @technical_review_expiration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @technical_review_expiration
    assert_response :success
  end

  test "should update technical_review_expiration" do
    patch :update, id: @technical_review_expiration, technical_review_expiration: { mes_venc_rev_tec: @technical_review_expiration.mes_venc_rev_tec, num_venc_rev_tec: @technical_review_expiration.num_venc_rev_tec }
    assert_redirected_to technical_review_expiration_path(assigns(:technical_review_expiration))
  end

  test "should destroy technical_review_expiration" do
    assert_difference('TechnicalReviewExpiration.count', -1) do
      delete :destroy, id: @technical_review_expiration
    end

    assert_redirected_to technical_review_expirations_path
  end
end
