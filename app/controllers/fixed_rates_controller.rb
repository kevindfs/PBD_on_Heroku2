class FixedRatesController < ApplicationController
  before_action :set_fixed_rate, only: [:show, :edit, :update, :destroy]

  # GET /fixed_rates
  # GET /fixed_rates.json
  def index
    @fixed_rates = FixedRate.all
  end

  # GET /fixed_rates/1
  # GET /fixed_rates/1.json
  def show
  end

  # GET /fixed_rates/new
  def new
    @fixed_rate = FixedRate.new
  end

  # GET /fixed_rates/1/edit
  def edit
  end

  # POST /fixed_rates
  # POST /fixed_rates.json
  def create
    @fixed_rate = FixedRate.new(fixed_rate_params)

    respond_to do |format|
      if @fixed_rate.save
        format.html { redirect_to @fixed_rate, notice: 'Fixed rate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fixed_rate }
      else
        format.html { render action: 'new' }
        format.json { render json: @fixed_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fixed_rates/1
  # PATCH/PUT /fixed_rates/1.json
  def update
    respond_to do |format|
      if @fixed_rate.update(fixed_rate_params)
        format.html { redirect_to @fixed_rate, notice: 'Fixed rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fixed_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixed_rates/1
  # DELETE /fixed_rates/1.json
  def destroy
    @fixed_rate.destroy
    respond_to do |format|
      format.html { redirect_to fixed_rates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_rate
      @fixed_rate = FixedRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fixed_rate_params
      params.require(:fixed_rate).permit(:ori_tar, :dest_tar, :costo_tar)
    end
end
