require 'test_helper'

class LogSqlsControllerTest < ActionController::TestCase
  setup do
    @log_sql = log_sqls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_sqls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_sql" do
    assert_difference('LogSql.count') do
      post :create, log_sql: { dat_antes_log_sql: @log_sql.dat_antes_log_sql, dat_desp_log_sql: @log_sql.dat_desp_log_sql, ope_det_log_sql: @log_sql.ope_det_log_sql, operac_log_sql: @log_sql.operac_log_sql, tabla_log_sql: @log_sql.tabla_log_sql, tms_log_sql: @log_sql.tms_log_sql, usuar_log_sql: @log_sql.usuar_log_sql }
    end

    assert_redirected_to log_sql_path(assigns(:log_sql))
  end

  test "should show log_sql" do
    get :show, id: @log_sql
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log_sql
    assert_response :success
  end

  test "should update log_sql" do
    patch :update, id: @log_sql, log_sql: { dat_antes_log_sql: @log_sql.dat_antes_log_sql, dat_desp_log_sql: @log_sql.dat_desp_log_sql, ope_det_log_sql: @log_sql.ope_det_log_sql, operac_log_sql: @log_sql.operac_log_sql, tabla_log_sql: @log_sql.tabla_log_sql, tms_log_sql: @log_sql.tms_log_sql, usuar_log_sql: @log_sql.usuar_log_sql }
    assert_redirected_to log_sql_path(assigns(:log_sql))
  end

  test "should destroy log_sql" do
    assert_difference('LogSql.count', -1) do
      delete :destroy, id: @log_sql
    end

    assert_redirected_to log_sqls_path
  end
end
