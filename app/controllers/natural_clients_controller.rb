class NaturalClientsController < ApplicationController
  before_action :set_natural_client, only: [:show, :edit, :update, :destroy]

  # GET /natural_clients
  # GET /natural_clients.json
  def index
    @natural_clients = NaturalClient.all
  end

  # GET /natural_clients/1
  # GET /natural_clients/1.json
  def show
  end

  # GET /natural_clients/new
  def new
    @natural_client = NaturalClient.new
  end

  # GET /natural_clients/1/edit
  def edit
  end

  # POST /natural_clients
  # POST /natural_clients.json
  def create
    @natural_client = NaturalClient.new(natural_client_params)

    respond_to do |format|
      if @natural_client.save
        format.html { redirect_to @natural_client, notice: 'Natural client was successfully created.' }
        format.json { render action: 'show', status: :created, location: @natural_client }
      else
        format.html { render action: 'new' }
        format.json { render json: @natural_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /natural_clients/1
  # PATCH/PUT /natural_clients/1.json
  def update
    respond_to do |format|
      if @natural_client.update(natural_client_params)
        format.html { redirect_to @natural_client, notice: 'Natural client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @natural_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /natural_clients/1
  # DELETE /natural_clients/1.json
  def destroy
    @natural_client.destroy
    respond_to do |format|
      format.html { redirect_to natural_clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_natural_client
      @natural_client = NaturalClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def natural_client_params
      params.require(:natural_client).permit(:run_cli)
    end
end
