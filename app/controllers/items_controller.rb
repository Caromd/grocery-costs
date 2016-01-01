class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @items = current_user.items.all.order('name asc')
  end

  def new
    @item = current_user.items.build
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path, notice: 'Item ' + @item.name + ' was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { redirect_to items_path, alert: @item.errors.full_messages.first }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_path, notice: 'Item ' + @item.name + ' was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @item.destroy
    if @item.destroy
      message = "Item destroyed successfully"
    else
      message = "**** ITEM COULD NOT BE DESTROYED ****"
    end
    respond_to do |format|
      format.html { redirect_to items_url, notice: message }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :type_id, :user_id)
    end
end