class ConductorController < ApplicationController
  def index
  	@travels = Travel.all
  	@travel_requests = TravelRequest.all
  	@clients = Client.all
   end

  def calendario

  end
end
