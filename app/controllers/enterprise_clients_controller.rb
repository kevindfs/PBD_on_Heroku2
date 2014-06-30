class EnterpriseClientsController < ApplicationController
  before_action :set_enterprise_client, only: [:show, :edit, :update, :destroy]

  # GET /enterprise_clients
  # GET /enterprise_clients.json
  def index
    @enterprise_clients = EnterpriseClient.all
  end

  # GET /enterprise_clients/1
  # GET /enterprise_clients/1.json
  def show
  end

  # GET /enterprise_clients/new
  def new
    @enterprise_client = EnterpriseClient.new
  end

  # GET /enterprise_clients/1/edit
  def edit
  end

  # POST /enterprise_clients
  # POST /enterprise_clients.json
  def create
    @enterprise_client = EnterpriseClient.new(enterprise_client_params)

    respond_to do |format|
      if @enterprise_client.save
        format.html { redirect_to @enterprise_client, notice: 'Enterprise client was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enterprise_client }
      else
        format.html { render action: 'new' }
        format.json { render json: @enterprise_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enterprise_clients/1
  # PATCH/PUT /enterprise_clients/1.json
  def update
    respond_to do |format|
      if @enterprise_client.update(enterprise_client_params)
        format.html { redirect_to @enterprise_client, notice: 'Enterprise client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enterprise_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enterprise_clients/1
  # DELETE /enterprise_clients/1.json
  def destroy
    @enterprise_client.destroy
    respond_to do |format|
      format.html { redirect_to enterprise_clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enterprise_client
      @enterprise_client = EnterpriseClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enterprise_client_params
      params.require(:enterprise_client).permit(:run_cli, :rut_ent)
    end
end
