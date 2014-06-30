class Transition < ActiveRecord::Base



    belongs_to :state, :class_name => 'State', :foreign_key => :id_stat    
    belongs_to :state, :class_name => 'State', :foreign_key => :sta_id_stat    
end
