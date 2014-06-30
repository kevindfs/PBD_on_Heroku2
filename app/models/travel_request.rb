class TravelRequest < ActiveRecord::Base

    self.primary_key = :id_trav_req

    has_many :travels, :class_name => 'Travel', :foreign_key => :id_trav_req    
    belongs_to :client, :class_name => 'Client', :foreign_key => :run_cli    

    validates_numericality_of :cant_pasaj_sol, :greater_than_or_equal_to => 1, :less_than => 5  , :message =>"Cantidad de pasajeros fuera de rango"
    validates_presence_of :dir_orig_sol, :message => "Falta origen" 
    validates_presence_of :dir_dest_sol, :message => "Falta destino" 
    validates_presence_of :com_orig_sol, :message => "Falta comuna origen" 
    validates_presence_of :com_dest_sol, :message => "Falta comuna destino" 

end
