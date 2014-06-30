class SchedulingBlock < ActiveRecord::Base

    self.primary_key = :id_block

    has_many :offer_vehicles, :class_name => 'OfferVehicle', :foreign_key => :id_block    
end
