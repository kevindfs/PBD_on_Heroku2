class ExternalEnterprise < ActiveRecord::Base

    self.primary_key = :rut_ent

    has_many :bills, :class_name => 'Bill', :foreign_key => :rut_ent    
    has_many :enterprise_clients, :class_name => 'EnterpriseClient', :foreign_key => :rut_ent    
end
