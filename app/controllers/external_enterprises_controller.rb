class ExternalEnterprisesController < ApplicationController
  before_action :set_external_enterprise, only: [:show, :edit, :update, :destroy]

  # GET /external_enterprises
  # GET /external_enterprises.json
  def index
    @external_enterprises = ExternalEnterprise.all
  end

  # GET /external_enterprises/1
  # GET /external_enterprises/1.json
  def show
  end

  # GET /external_enterprises/new
  def new
    @external_enterprise = ExternalEnterprise.new
  end

  # GET /external_enterprises/1/edit
  def edit
  end

  # POST /external_enterprises
  # POST /external_enterprises.json
  def create
    @external_enterprise = ExternalEnterprise.new(external_enterprise_params)

    respond_to do |format|
      if @external_enterprise.save
        format.html { redirect_to @external_enterprise, notice: 'External enterprise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @external_enterprise }
      else
        format.html { render action: 'new' }
        format.json { render json: @external_enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_enterprises/1
  # PATCH/PUT /external_enterprises/1.json
  def update
    respond_to do |format|
      if @external_enterprise.update(external_enterprise_params)
        format.html { redirect_to @external_enterprise, notice: 'External enterprise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @external_enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_enterprises/1
  # DELETE /external_enterprises/1.json
  def destroy
    @external_enterprise.destroy
    respond_to do |format|
      format.html { redirect_to external_enterprises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_enterprise
      @external_enterprise = ExternalEnterprise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def external_enterprise_params
      params.require(:external_enterprise).permit(:rut_ent, :giro_emp, :nom_emp, :dir_emp, :tel1_emp, :tel2_emp, :email_emp, :est_conv_emp, :ini_conv_emp, :fin_conv_emp, :descrip_conv_emp)
    end
end
