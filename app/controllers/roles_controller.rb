class RolesController < ApplicationController
  def index
  	@users = User.all
    @clients = Client.all
    @natural_clients = NaturalClient.all

   	@rut = params[:rut]
   	@correo = params[:correo]
   	@rol = params[:role]

  end
end
