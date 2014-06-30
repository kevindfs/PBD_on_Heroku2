require 'test_helper'

class ExternalEnterprisesControllerTest < ActionController::TestCase
  setup do
    @external_enterprise = external_enterprises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:external_enterprises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create external_enterprise" do
    assert_difference('ExternalEnterprise.count') do
      post :create, external_enterprise: { descrip_conv_emp: @external_enterprise.descrip_conv_emp, dir_emp: @external_enterprise.dir_emp, email_emp: @external_enterprise.email_emp, est_conv_emp: @external_enterprise.est_conv_emp, fin_conv_emp: @external_enterprise.fin_conv_emp, giro_emp: @external_enterprise.giro_emp, ini_conv_emp: @external_enterprise.ini_conv_emp, nom_emp: @external_enterprise.nom_emp, rut_ent: @external_enterprise.rut_ent, tel1_emp: @external_enterprise.tel1_emp, tel2_emp: @external_enterprise.tel2_emp }
    end

    assert_redirected_to external_enterprise_path(assigns(:external_enterprise))
  end

  test "should show external_enterprise" do
    get :show, id: @external_enterprise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @external_enterprise
    assert_response :success
  end

  test "should update external_enterprise" do
    patch :update, id: @external_enterprise, external_enterprise: { descrip_conv_emp: @external_enterprise.descrip_conv_emp, dir_emp: @external_enterprise.dir_emp, email_emp: @external_enterprise.email_emp, est_conv_emp: @external_enterprise.est_conv_emp, fin_conv_emp: @external_enterprise.fin_conv_emp, giro_emp: @external_enterprise.giro_emp, ini_conv_emp: @external_enterprise.ini_conv_emp, nom_emp: @external_enterprise.nom_emp, rut_ent: @external_enterprise.rut_ent, tel1_emp: @external_enterprise.tel1_emp, tel2_emp: @external_enterprise.tel2_emp }
    assert_redirected_to external_enterprise_path(assigns(:external_enterprise))
  end

  test "should destroy external_enterprise" do
    assert_difference('ExternalEnterprise.count', -1) do
      delete :destroy, id: @external_enterprise
    end

    assert_redirected_to external_enterprises_path
  end
end
