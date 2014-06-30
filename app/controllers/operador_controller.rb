require 'open-uri'
require 'json'
require 'net/http'

class OperadorController < ApplicationController
  def index

    @kilometers_prices = KilometersPrice.all
    @base_prices = BasePrice.all
	$result = { "destination_addresses" => ["Calle1,SC,Ch"], "origin_addresses" => ["LJ, EC, RM"], "rows" => [{"elements" => [{"distance" => {"text" => "10km", "value" => 1000}, "duration" => {"text" => "15min", "value" => 903}, "status" => "OK"}]}], "status" => "OK"}	
  	@origen = params[:origen]
  	@destino = params[:destino]
	@url_base = "http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@origen}&destinations=#{@destino}&mode=driving&language=es-ES&gl=es".delete(' ')
	@encoded_url = URI.encode(@url_base)
	@resp = Net::HTTP.get_response(URI.parse(@encoded_url))
	@data = @resp.body
	$result = JSON.parse(@data)
	
	@destination_addresses = $result["destination_addresses"][0]
	@origin_addresses = $result["origin_addresses"][0]
	@status = $result['status']
	
	@valor_km_vigente
	@kilometers_prices.each do |kp|
		if (kp.estado_val_km == 'activo')
			@valor_km_vigente=kp.val_km
		end

	end

	
	@costo_total=0

		
	
	if (@status == "INVALID_REQUEST")
		
		@error1 = "Request invalido"

	elsif ($result["rows"][0]["elements"][0]["status"]=="NOT_FOUND" || $result["rows"][0]["elements"][0]["status"]=="ZERO_RESULTS")
		
		@error2 = "Error 2"
		#@Mensaje_alerta = "Ingrese un requerimiento válido"
		#ENVIAR MENSAJE DE REQUERIMIENTO INVÁLIDO
	
	elsif (@status == "OK")
		@distance = $result["rows"][0]["elements"][0]["distance"]["value"]
		@duration = $result["rows"][0]["elements"][0]["duration"]["value"]
		@duration_min = (@duration/60).round
		@distance_km = (@distance*0.001).round(1)
		@costo_total= (@valor_km_vigente)*@distance_km
	
	else
		@error1 = "ELSE"
	end
	
  end

  def solicitudes
    @travel_requests = TravelRequest.all



  end

  def disp_conductor
  end

  def usuarios_reg
  	  	@users = User.all

  end
end
