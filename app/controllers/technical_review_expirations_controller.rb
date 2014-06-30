class TechnicalReviewExpirationsController < ApplicationController
  before_action :set_technical_review_expiration, only: [:show, :edit, :update, :destroy]

  # GET /technical_review_expirations
  # GET /technical_review_expirations.json
  def index
    @technical_review_expirations = TechnicalReviewExpiration.all
  end

  # GET /technical_review_expirations/1
  # GET /technical_review_expirations/1.json
  def show
  end

  # GET /technical_review_expirations/new
  def new
    @technical_review_expiration = TechnicalReviewExpiration.new
  end

  # GET /technical_review_expirations/1/edit
  def edit
  end

  # POST /technical_review_expirations
  # POST /technical_review_expirations.json
  def create
    @technical_review_expiration = TechnicalReviewExpiration.new(technical_review_expiration_params)

    respond_to do |format|
      if @technical_review_expiration.save
        format.html { redirect_to @technical_review_expiration, notice: 'Technical review expiration was successfully created.' }
        format.json { render action: 'show', status: :created, location: @technical_review_expiration }
      else
        format.html { render action: 'new' }
        format.json { render json: @technical_review_expiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technical_review_expirations/1
  # PATCH/PUT /technical_review_expirations/1.json
  def update
    respond_to do |format|
      if @technical_review_expiration.update(technical_review_expiration_params)
        format.html { redirect_to @technical_review_expiration, notice: 'Technical review expiration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @technical_review_expiration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technical_review_expirations/1
  # DELETE /technical_review_expirations/1.json
  def destroy
    @technical_review_expiration.destroy
    respond_to do |format|
      format.html { redirect_to technical_review_expirations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technical_review_expiration
      @technical_review_expiration = TechnicalReviewExpiration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technical_review_expiration_params
      params.require(:technical_review_expiration).permit(:mes_venc_rev_tec, :num_venc_rev_tec)
    end
end
