class TechnicalReviewAlertsController < ApplicationController
  before_action :set_technical_review_alert, only: [:show, :edit, :update, :destroy]

  # GET /technical_review_alerts
  # GET /technical_review_alerts.json
  def index
    @technical_review_alerts = TechnicalReviewAlert.all
  end

  # GET /technical_review_alerts/1
  # GET /technical_review_alerts/1.json
  def show
  end

  # GET /technical_review_alerts/new
  def new
    @technical_review_alert = TechnicalReviewAlert.new
  end

  # GET /technical_review_alerts/1/edit
  def edit
  end

  # POST /technical_review_alerts
  # POST /technical_review_alerts.json
  def create
    @technical_review_alert = TechnicalReviewAlert.new(technical_review_alert_params)

    respond_to do |format|
      if @technical_review_alert.save
        format.html { redirect_to @technical_review_alert, notice: 'Technical review alert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @technical_review_alert }
      else
        format.html { render action: 'new' }
        format.json { render json: @technical_review_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technical_review_alerts/1
  # PATCH/PUT /technical_review_alerts/1.json
  def update
    respond_to do |format|
      if @technical_review_alert.update(technical_review_alert_params)
        format.html { redirect_to @technical_review_alert, notice: 'Technical review alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @technical_review_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technical_review_alerts/1
  # DELETE /technical_review_alerts/1.json
  def destroy
    @technical_review_alert.destroy
    respond_to do |format|
      format.html { redirect_to technical_review_alerts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technical_review_alert
      @technical_review_alert = TechnicalReviewAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technical_review_alert_params
      params.require(:technical_review_alert).permit(:plant_alert_rev_tec)
    end
end
