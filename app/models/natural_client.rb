class NaturalClient < ActiveRecord::Base



    belongs_to :client, :class_name => 'Client', :foreign_key => :run_cli    
end
