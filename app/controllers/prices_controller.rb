class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]
#  before_action :set_item, only: [:index]


  def summary
#    if (params[:month] != "" && params[:year] != "")  && (params[:month] != nil && params[:year] != nil)
    if (params[:month] != "" && params[:month] != nil)
      month=params[:month].to_i
      year=params[:year].to_i
      dt = DateTime.new(year, month,1)
      bom = dt.beginning_of_month
      eom = dt.end_of_month
      @prices = Price.where("date_bought >= ? and date_bought <= ?", bom, eom)
#     @prices = Price.summary(params[:year], params[:month])
      @items = Item.all
      @types = Type.all
    else  
      flash[:alert] = "Please enter month and year to summarise"
      #redirect_to @summary
    end
  end
  
  # GET /prices
  # GET /prices.json
  def index
    @prices = Price.all
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = Price.new
  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = Price.new(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to prices_path, notice: 'Price was successfully created.' }
        format.json { render :show, status: :created, location: @price }
      else
        format.html { render :new }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to @price, notice: 'Price was successfully updated.' }
        format.json { render :show, status: :ok, location: @price }
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
    
    def set_item
      @item = Item.find(params[:item_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:amount, :date_bought, :item_id, :date, :year, :month)
    end
end
