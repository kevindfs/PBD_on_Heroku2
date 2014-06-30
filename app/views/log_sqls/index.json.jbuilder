json.array!(@log_sqls) do |log_sql|
  json.extract! log_sql, :id, :tms_log_sql, :tabla_log_sql, :operac_log_sql, :usuar_log_sql, :dat_antes_log_sql, :dat_desp_log_sql, :ope_det_log_sql
  json.url log_sql_url(log_sql, format: :json)
end
