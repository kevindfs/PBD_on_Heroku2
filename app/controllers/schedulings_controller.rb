class SchedulingsController < ApplicationController
  before_action :set_scheduling, only: [:show, :edit, :update, :destroy]

  # GET /schedulings
  # GET /schedulings.json
  def index
    @schedulings = Scheduling.all
  end

  # GET /schedulings/1
  # GET /schedulings/1.json
  def show
  end

  # GET /schedulings/new
  def new
    @scheduling = Scheduling.new
  end

  # GET /schedulings/1/edit
  def edit
  end

  # POST /schedulings
  # POST /schedulings.json
  def create
    @scheduling = Scheduling.new(scheduling_params)

    respond_to do |format|
      if @scheduling.save
        format.html { redirect_to @scheduling, notice: 'Scheduling was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scheduling }
      else
        format.html { render action: 'new' }
        format.json { render json: @scheduling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedulings/1
  # PATCH/PUT /schedulings/1.json
  def update
    respond_to do |format|
      if @scheduling.update(scheduling_params)
        format.html { redirect_to @scheduling, notice: 'Scheduling was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scheduling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedulings/1
  # DELETE /schedulings/1.json
  def destroy
    @scheduling.destroy
    respond_to do |format|
      format.html { redirect_to schedulings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduling
      @scheduling = Scheduling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scheduling_params
      params.require(:scheduling).permit(:id_off_veh, :run_driv, :run_cli, :cli_run_cli)
    end
end
