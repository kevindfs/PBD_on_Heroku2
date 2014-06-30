class Vehicle < ActiveRecord::Base

    self.primary_key = :id_veh

    has_many :assigneds, :class_name => 'Assigned', :foreign_key => :id_veh    
    has_many :offer_vehicles, :class_name => 'OfferVehicle', :foreign_key => :id_veh    
    belongs_to :owner, :class_name => 'Owner', :foreign_key => :run_own    
    
    validates_presence_of :pat_veh, :message => "Falta Patente"
    validates_presence_of :mar_veh, :message => "Falta Marca Vehiculo" 
    validates_presence_of :model_veh, :message => "Falta Modelo Vehiculo" 
    validates_presence_of :tipo_veh, :message => "Falta Tipo Vehiculo" 
	validates_numericality_of :km_sem_veh, :greater_than_or_equal_to => 0,  :message =>"km>=0"

	
end
