class DriversLicenseAlertsController < ApplicationController
  before_action :set_drivers_license_alert, only: [:show, :edit, :update, :destroy]

  # GET /drivers_license_alerts
  # GET /drivers_license_alerts.json
  def index
    @drivers_license_alerts = DriversLicenseAlert.all
  end

  # GET /drivers_license_alerts/1
  # GET /drivers_license_alerts/1.json
  def show
  end

  # GET /drivers_license_alerts/new
  def new
    @drivers_license_alert = DriversLicenseAlert.new
  end

  # GET /drivers_license_alerts/1/edit
  def edit
  end

  # POST /drivers_license_alerts
  # POST /drivers_license_alerts.json
  def create
    @drivers_license_alert = DriversLicenseAlert.new(drivers_license_alert_params)

    respond_to do |format|
      if @drivers_license_alert.save
        format.html { redirect_to @drivers_license_alert, notice: 'Drivers license alert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @drivers_license_alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @drivers_license_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drivers_license_alerts/1
  # PATCH/PUT /drivers_license_alerts/1.json
  def update
    respond_to do |format|
      if @drivers_license_alert.update(drivers_license_alert_params)
        format.html { redirect_to @drivers_license_alert, notice: 'Drivers license alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @drivers_license_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drivers_license_alerts/1
  # DELETE /drivers_license_alerts/1.json
  def destroy
    @drivers_license_alert.destroy
    respond_to do |format|
      format.html { redirect_to drivers_license_alerts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drivers_license_alert
      @drivers_license_alert = DriversLicenseAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drivers_license_alert_params
      params.require(:drivers_license_alert).permit(:plant_alert_licenc)
    end
end
