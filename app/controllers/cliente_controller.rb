#encoding: utf-8
class ClienteController < ApplicationController
  def estado
  end

  def solicitud
   	@nombre = params[:nombre]
  	@fecha = params[:fecha_viaje]
  	@h_viaje = params[:hora_viaje]
  	@o_viaje = params[:origen_viaje]
  	@c_origen = params[:comuna_origen]
  	@d_viaje = params[:destino_viaje]
  	@c_destino = params[:comuna_destino]
  	@c_pasajeros = params[:cantidad_pasajeros]
	@prueba = params[:opcion]
    @comunnes = Comunne.all
    @comuna_entrada=""
    @role = params[:role]

  end

  def condiciones
  end
end
