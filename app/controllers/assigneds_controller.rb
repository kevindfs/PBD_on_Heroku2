class AssignedsController < ApplicationController
  before_action :set_assigned, only: [:show, :edit, :update, :destroy]

  # GET /assigneds
  # GET /assigneds.json
  def index
    @assigneds = Assigned.all
  end

  # GET /assigneds/1
  # GET /assigneds/1.json
  def show
  end

  # GET /assigneds/new
  def new
    @assigned = Assigned.new
  end

  # GET /assigneds/1/edit
  def edit
  end

  # POST /assigneds
  # POST /assigneds.json
  def create
    @assigned = Assigned.new(assigned_params)

    respond_to do |format|
      if @assigned.save
        format.html { redirect_to @assigned, notice: 'Assigned was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assigned }
      else
        format.html { render action: 'new' }
        format.json { render json: @assigned.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assigneds/1
  # PATCH/PUT /assigneds/1.json
  def update
    respond_to do |format|
      if @assigned.update(assigned_params)
        format.html { redirect_to @assigned, notice: 'Assigned was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assigned.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assigneds/1
  # DELETE /assigneds/1.json
  def destroy
    @assigned.destroy
    respond_to do |format|
      format.html { redirect_to assigneds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assigned
      @assigned = Assigned.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assigned_params
      params.require(:assigned).permit(:id_veh, :run_driv, :ini_assigned, :fin_assigned)
    end
end
