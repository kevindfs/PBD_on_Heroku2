class StateHistory < ActiveRecord::Base



    belongs_to :travel, :class_name => 'Travel', :foreign_key => :id_trav    
    belongs_to :state, :class_name => 'State', :foreign_key => :id_stat    
end
