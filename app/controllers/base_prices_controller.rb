class BasePricesController < ApplicationController
  before_action :set_base_price, only: [:show, :edit, :update, :destroy]

  # GET /base_prices
  # GET /base_prices.json
  def index
    @base_prices = BasePrice.all
  end

  # GET /base_prices/1
  # GET /base_prices/1.json
  def show
  end

  # GET /base_prices/new
  def new
    @base_price = BasePrice.new
  end

  # GET /base_prices/1/edit
  def edit
  end

  # POST /base_prices
  # POST /base_prices.json
  def create
    @base_price = BasePrice.new(base_price_params)

    respond_to do |format|
      if @base_price.save
        format.html { redirect_to @base_price, notice: 'Base price was successfully created.' }
        format.json { render action: 'show', status: :created, location: @base_price }
      else
        format.html { render action: 'new' }
        format.json { render json: @base_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /base_prices/1
  # PATCH/PUT /base_prices/1.json
  def update
    respond_to do |format|
      if @base_price.update(base_price_params)
        format.html { redirect_to @base_price, notice: 'Base price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @base_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_prices/1
  # DELETE /base_prices/1.json
  def destroy
    @base_price.destroy
    respond_to do |format|
      format.html { redirect_to base_prices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_base_price
      @base_price = BasePrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def base_price_params
      params.require(:base_price).permit(:val_base, :ini_val_base, :fin_val_base, :estado_val_base)
    end
end
