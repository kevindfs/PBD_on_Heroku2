class ComunnesController < ApplicationController
  before_action :set_comunne, only: [:show, :edit, :update, :destroy]

  # GET /comunnes
  # GET /comunnes.json
  def index
    @comunnes = Comunne.all
  end

  # GET /comunnes/1
  # GET /comunnes/1.json
  def show
  end

  # GET /comunnes/new
  def new
    @comunne = Comunne.new
  end

  # GET /comunnes/1/edit
  def edit
  end

  # POST /comunnes
  # POST /comunnes.json
  def create
    @comunne = Comunne.new(comunne_params)

    respond_to do |format|
      if @comunne.save
        format.html { redirect_to @comunne, notice: 'Comunne was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comunne }
      else
        format.html { render action: 'new' }
        format.json { render json: @comunne.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comunnes/1
  # PATCH/PUT /comunnes/1.json
  def update
    respond_to do |format|
      if @comunne.update(comunne_params)
        format.html { redirect_to @comunne, notice: 'Comunne was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comunne.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comunnes/1
  # DELETE /comunnes/1.json
  def destroy
    @comunne.destroy
    respond_to do |format|
      format.html { redirect_to comunnes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comunne
      @comunne = Comunne.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comunne_params
      params.require(:comunne).permit(:nom_comun, :num_comun)
    end
end
