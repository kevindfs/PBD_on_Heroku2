class KilometersPricesController < ApplicationController
  before_action :set_kilometers_price, only: [:show, :edit, :update, :destroy]

  # GET /kilometers_prices
  # GET /kilometers_prices.json
  def index
    @kilometers_prices = KilometersPrice.all
  end

  # GET /kilometers_prices/1
  # GET /kilometers_prices/1.json
  def show
  end

  # GET /kilometers_prices/new
  def new
    @kilometers_price = KilometersPrice.new
  end

  # GET /kilometers_prices/1/edit
  def edit
  end

  # POST /kilometers_prices
  # POST /kilometers_prices.json
  def create
    @kilometers_price = KilometersPrice.new(kilometers_price_params)

    respond_to do |format|
      if @kilometers_price.save
        format.html { redirect_to @kilometers_price, notice: 'Kilometers price was successfully created.' }
        format.json { render action: 'show', status: :created, location: @kilometers_price }
      else
        format.html { render action: 'new' }
        format.json { render json: @kilometers_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kilometers_prices/1
  # PATCH/PUT /kilometers_prices/1.json
  def update
    respond_to do |format|
      if @kilometers_price.update(kilometers_price_params)
        format.html { redirect_to @kilometers_price, notice: 'Kilometers price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @kilometers_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kilometers_prices/1
  # DELETE /kilometers_prices/1.json
  def destroy
    @kilometers_price.destroy
    respond_to do |format|
      format.html { redirect_to kilometers_prices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kilometers_price
      @kilometers_price = KilometersPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kilometers_price_params
      params.require(:kilometers_price).permit(:val_km, :ini_val_km, :fin_val_km, :estado_val_km)
    end
end
