class BillDetail < ActiveRecord::Base

    self.primary_key = :id_bill_det

    belongs_to :bill, :class_name => 'Bill', :foreign_key => :id_bil    
    belongs_to :concept, :class_name => 'Concept', :foreign_key => :id_conc    
end
