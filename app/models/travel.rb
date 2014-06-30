class Travel < ActiveRecord::Base

    self.primary_key = :id_trav

    has_many :state_histories, :class_name => 'StateHistory', :foreign_key => :id_trav    
    belongs_to :driver, :class_name => 'Driver', :foreign_key => :run_driv    
    belongs_to :travel_request, :class_name => 'TravelRequest', :foreign_key => :id_trav_req    
end
