class State < ActiveRecord::Base

    self.primary_key = :id_stat

    has_many :state_histories, :class_name => 'StateHistory', :foreign_key => :id_stat    
    has_many :transitions, :class_name => 'Transition', :foreign_key => :id_stat    
    has_many :transitions, :class_name => 'Transition'    
end
