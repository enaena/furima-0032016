class OrdersController < ApplicationController

  def index
    @form = Form.new
    @item = Item.find(params[:item_id])
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      @form.save
      redirect_to root_path
    else
    @item = Item.find(params[:item_id])
    render :index
    end
  end

  private
  def form_params
    params.require(:form).permit(:postal_code, :area_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id,item_id:params[:item_id])
  end

end
