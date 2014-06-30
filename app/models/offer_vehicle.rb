class OfferVehicle < ActiveRecord::Base

    self.primary_key = :id_off_veh

    belongs_to :scheduling_block, :class_name => 'SchedulingBlock', :foreign_key => :id_block    
    belongs_to :driver, :class_name => 'Driver', :foreign_key => :run_driv    
    has_many :schedulings, :class_name => 'Scheduling', :foreign_key => :id_off_veh    
end
