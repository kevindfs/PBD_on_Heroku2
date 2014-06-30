class Client < ActiveRecord::Base

    self.primary_key = :run_cli

    has_many :enterprise_clients, :class_name => 'EnterpriseClient', :foreign_key => :run_cli    
    has_many :natural_clients, :class_name => 'NaturalClient', :foreign_key => :run_cli    
    has_many :schedulings, :class_name => 'Scheduling', :foreign_key => :run_cli    
    has_many :travel_requests, :class_name => 'TravelRequest', :foreign_key => :run_cli    
end
