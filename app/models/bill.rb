class Bill < ActiveRecord::Base

    self.primary_key = :id_bil

    belongs_to :external_enterprise, :class_name => 'ExternalEnterprise', :foreign_key => :rut_ent    
    has_many :bill_details, :class_name => 'BillDetail', :foreign_key => :id_bil    
end
