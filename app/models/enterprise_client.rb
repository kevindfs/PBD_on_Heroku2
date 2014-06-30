class EnterpriseClient < ActiveRecord::Base



    belongs_to :client, :class_name => 'Client', :foreign_key => :run_cli    
    belongs_to :external_enterprise, :class_name => 'ExternalEnterprise', :foreign_key => :rut_ent    
end
