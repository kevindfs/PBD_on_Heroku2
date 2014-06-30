class OwnerCommissionsController < ApplicationController
  before_action :set_owner_commission, only: [:show, :edit, :update, :destroy]

  # GET /owner_commissions
  # GET /owner_commissions.json
  def index
    @owner_commissions = OwnerCommission.all
  end

  # GET /owner_commissions/1
  # GET /owner_commissions/1.json
  def show
  end

  # GET /owner_commissions/new
  def new
    @owner_commission = OwnerCommission.new
  end

  # GET /owner_commissions/1/edit
  def edit
  end

  # POST /owner_commissions
  # POST /owner_commissions.json
  def create
    @owner_commission = OwnerCommission.new(owner_commission_params)

    respond_to do |format|
      if @owner_commission.save
        format.html { redirect_to @owner_commission, notice: 'Owner commission was successfully created.' }
        format.json { render action: 'show', status: :created, location: @owner_commission }
      else
        format.html { render action: 'new' }
        format.json { render json: @owner_commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /owner_commissions/1
  # PATCH/PUT /owner_commissions/1.json
  def update
    respond_to do |format|
      if @owner_commission.update(owner_commission_params)
        format.html { redirect_to @owner_commission, notice: 'Owner commission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @owner_commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owner_commissions/1
  # DELETE /owner_commissions/1.json
  def destroy
    @owner_commission.destroy
    respond_to do |format|
      format.html { redirect_to owner_commissions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner_commission
      @owner_commission = OwnerCommission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def owner_commission_params
      params.require(:owner_commission).permit(:porcent_comi_prop, :ini_comi_prop, :fin_comi_prop)
    end
end
