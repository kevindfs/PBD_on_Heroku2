class Assigned < ActiveRecord::Base



    belongs_to :vehicle, :class_name => 'Vehicle', :foreign_key => :id_veh    
    belongs_to :driver, :class_name => 'Driver', :foreign_key => :run_driv    
end
