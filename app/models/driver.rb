class Driver < ActiveRecord::Base

    self.primary_key = :run_driv

    has_many :assigneds, :class_name => 'Assigned', :foreign_key => :run_driv    
    has_many :schedulings, :class_name => 'Scheduling', :foreign_key => :run_driv    
    has_many :travels, :class_name => 'Travel', :foreign_key => :run_driv    
end
