json.array!(@external_enterprises) do |external_enterprise|
  json.extract! external_enterprise, :id, :rut_ent, :giro_emp, :nom_emp, :dir_emp, :tel1_emp, :tel2_emp, :email_emp, :est_conv_emp, :ini_conv_emp, :fin_conv_emp, :descrip_conv_emp
  json.url external_enterprise_url(external_enterprise, format: :json)
end
