class ShoppingDaysController < ApplicationController
  before_action :set_shopping_day, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def summary
    if (params[:month] != "" && params[:month] != nil)
      month=params[:month].to_i
      year=params[:year].to_i
      dt = DateTime.new(year, month,1)
      bom = dt.beginning_of_month
      eom = dt.end_of_month
      @shopping_days = current_user.shopping_days.where("date_bought >= ? and date_bought <= ?", bom, eom)
      #  Fix this --> check how to do this join
      @prices = current_user.prices # where @shopping_days
      @items = current_user.items.all
      @types = current_user.types.all
    else  
      flash[:alert] = "Please enter month and year to summarise"
    end
  end
  
  def index
    @shopping_days = current_user.shopping_days.all
  end

  def new
    @shopping_day = current_user.shopping_days.build
    5.times do
        @prices = @shopping_day.prices.build
    end
  end

  def edit
  end

  def create
    @shopping_day = current_user.shopping_days.build(shopping_day_params)

    respond_to do |format|
      if @shopping_day.save
        format.html { redirect_to shopping_days_path, notice: 'Shopping_day was successfully created.' }
        format.json { render :index, status: :created, location: @shopping_day }
      else
        format.html { redirect_to shopping_days_path, alert: @shopping_day.errors.full_messages.first }
        format.json { render json: @shopping_day.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shopping_day.update(shopping_day_params)
        format.html { redirect_to shopping_days_path, notice: 'Shopping_day was successfully updated.' }
        format.json { render :index, status: :ok, location: @shopping_day }
      else
        format.html { render :edit }
        format.json { render json: @shopping_day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shopping_day.destroy
    respond_to do |format|
      format.html { redirect_to shopping_days_url, notice: 'Shopping_day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping_day
      @shopping_day = ShoppingDay.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def shopping_day_params
      params.require(:shopping_day).permit(:date_bought,  :user_id, :date, :year, :month, 
      prices_attributes: [ :id, :amount, :name, :item_id, :user_id, :_destroy]
      )
    end
end