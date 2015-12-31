class TypesController < ApplicationController
  before_action :set_type, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @types = current_user.types.all.order('name asc')
  end

  def new
    @type = current_user.types.build
  end

  def edit
  end

  def create
    @type = current_user.types.build(type_params)

    respond_to do |format|
      if @type.save
        format.html { redirect_to types_path, notice: 'Type was successfully created.' }
        format.json { render :index, status: :created, location: @type }
      else
        format.html { redirect_to types_path, alert: @type.errors.full_messages.first }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @type.update(type_params)
        format.html { redirect_to types_url, notice: 'Type was successfully updated.' }
        format.json { render :index, status: :ok, location: @types }
      else
        format.html { render :edit }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @type.destroy
      message = "Type destroyed successfully"
    else
      message = "**** TYPE COULD NOT BE DESTROYED ****"
    end
    respond_to do |format|
      format.html { redirect_to types_url, notice: message }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type
      @type = Type.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_params
      params.require(:type).permit(:name, :user_id)
    end
end
