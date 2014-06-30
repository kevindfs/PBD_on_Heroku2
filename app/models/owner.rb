class Owner < ActiveRecord::Base

    self.primary_key = :run_own

    has_many :vehicles, :class_name => 'Vehicle', :foreign_key => :run_own    

    validates :run_own, rut: true
    validates_presence_of :run_own, :message => "Falta Rut propietario" 
    validates_presence_of :nom_prop, :message => "Falta Nombre propietario" 
    validates_presence_of :apells_prop, :message => "Falta Apellido propietario" 
    validates_presence_of :tel_prop, :message => "Falta Telefono propietario" 
    validates_presence_of :email_prop, :message => "Falta Email propietario" 

end