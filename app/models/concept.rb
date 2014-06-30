class Concept < ActiveRecord::Base

    self.primary_key = :id_conc

    has_many :bill_details, :class_name => 'BillDetail', :foreign_key => :id_conc    
end
