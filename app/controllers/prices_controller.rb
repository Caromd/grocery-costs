class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @prices = current_user.prices.all.includes(:item)
  end

  def new
    @price = current_user.prices.build
  end

  def edit
  end

  def create
    @price = current_user.prices.build(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to prices_path, notice: 'Price was successfully created.' }
        format.json { render :index, status: :created, location: @price }
      else
        format.html { redirect_to prices_path, alert: @price.errors.full_messages.first }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

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
      params.require(:price).permit(:amount, :item_id, :user_id)
    end
end