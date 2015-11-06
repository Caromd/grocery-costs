class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def summary
    if (params[:month] != "" && params[:month] != nil)
      month=params[:month].to_i
      year=params[:year].to_i
      dt = DateTime.new(year, month,1)
      bom = dt.beginning_of_month
      eom = dt.end_of_month
      @prices = current_user.prices.where("date_bought >= ? and date_bought <= ?", bom, eom)
      @items = current_user.items.all
      @types = current_user.types.all
    else  
      flash[:alert] = "Please enter month and year to summarise"
    end
  end
  
  # GET /prices
  # GET /prices.json
  def index
    @prices = current_user.prices.all.includes(:item)
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = current_user.prices.build
  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = current_user.prices.build(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to prices_path, notice: 'Price was successfully created.' }
        format.json { render :index, status: :created, location: @price }
      else
        format.html { redirect_to prices_path, notice: @price.errors }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to prices_path, notice: 'Price was successfully updated.' }
        format.json { render :index, status: :ok, location: @price }
      else
        format.html { render :edit }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to prices_url, notice: 'Price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:amount, :date_bought, :item_id, :date, :year, :month)
    end
end
