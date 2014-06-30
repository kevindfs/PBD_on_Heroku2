class Scheduling < ActiveRecord::Base



    belongs_to :offer_vehicle, :class_name => 'OfferVehicle', :foreign_key => :id_off_veh    
    belongs_to :driver, :class_name => 'Driver', :foreign_key => :run_driv    
    belongs_to :client, :class_name => 'Client', :foreign_key => :run_cli    
end
