class OfferVehiclesController < ApplicationController
  before_action :set_offer_vehicle, only: [:show, :edit, :update, :destroy]

  # GET /offer_vehicles
  # GET /offer_vehicles.json
  def index
    @offer_vehicles = OfferVehicle.all
    @drivers = Driver.all
    @scheduling_blocks = SchedulingBlock.all


  end

  # GET /offer_vehicles/1
  # GET /offer_vehicles/1.json
  def show
  end

  # GET /offer_vehicles/new
  def new
    @offer_vehicle = OfferVehicle.new
    @drivers = Driver.all
    @scheduling_blocks = SchedulingBlock.all



  end

  # GET /offer_vehicles/1/edit
  def edit
  end

  # POST /offer_vehicles
  # POST /offer_vehicles.json
  def create
    @offer_vehicle = OfferVehicle.new(offer_vehicle_params)

    respond_to do |format|
      if @offer_vehicle.save
        format.html { redirect_to @offer_vehicle, notice: 'Offer vehicle was successfully created.' }
        format.json { render action: 'show', status: :created, location: @offer_vehicle }
      else
        format.html { render action: 'new' }
        format.json { render json: @offer_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offer_vehicles/1
  # PATCH/PUT /offer_vehicles/1.json
  def update
    respond_to do |format|
      if @offer_vehicle.update(offer_vehicle_params)
        format.html { redirect_to @offer_vehicle, notice: 'Offer vehicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offer_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_vehicles/1
  # DELETE /offer_vehicles/1.json
  def destroy
    @offer_vehicle.destroy
    respond_to do |format|
      format.html { redirect_to offer_vehicles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer_vehicle
      @offer_vehicle = OfferVehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_vehicle_params
      params.require(:offer_vehicle).permit(:id_block, :run_driv, :est_oferta_veh)
    end
end
