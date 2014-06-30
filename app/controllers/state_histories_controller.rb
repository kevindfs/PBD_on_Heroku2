class StateHistoriesController < ApplicationController
  before_action :set_state_history, only: [:show, :edit, :update, :destroy]

  # GET /state_histories
  # GET /state_histories.json
  def index
    @state_histories = StateHistory.all
  end

  # GET /state_histories/1
  # GET /state_histories/1.json
  def show
  end

  # GET /state_histories/new
  def new
    @state_history = StateHistory.new
  end

  # GET /state_histories/1/edit
  def edit
  end

  # POST /state_histories
  # POST /state_histories.json
  def create
    @state_history = StateHistory.new(state_history_params)

    respond_to do |format|
      if @state_history.save
        format.html { redirect_to @state_history, notice: 'State history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @state_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @state_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /state_histories/1
  # PATCH/PUT /state_histories/1.json
  def update
    respond_to do |format|
      if @state_history.update(state_history_params)
        format.html { redirect_to @state_history, notice: 'State history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @state_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /state_histories/1
  # DELETE /state_histories/1.json
  def destroy
    @state_history.destroy
    respond_to do |format|
      format.html { redirect_to state_histories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state_history
      @state_history = StateHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_history_params
      params.require(:state_history).permit(:id_trav, :id_stat)
    end
end
