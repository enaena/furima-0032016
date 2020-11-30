class OrdersController < ApplicationController

  def index
    @form = Form.new
    @item = Item.find(params[:item_id])
  end

  def create
    @form = Form.new(form_params)
    @item = Item.find(params[:item_id])
    if @form.valid?
      @form.save
      pay_item
      redirect_to root_path
    else
    @item = Item.find(params[:item_id])
    render :index
    end
  end

  private
  def form_params
    params.require(:form).permit(:postal_code, :area_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id,item_id:params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: form_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
