class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create,]
  before_action :sold_out_item, only: [:index]
  before_action :move_to_index_sign, only: [:index]
  before_action :move_to_index, only: [:index]

  def index
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    if @form.valid?
      pay_item
      @form.save
      redirect_to root_path
    else
      render :index
    end
  end

  def sold_out_item
    redirect_to root_path if @item.order.present?
  end

  def move_to_index_sign
    redirect_to root_path unless user_signed_in?
  end

  def move_to_index
    if current_user.id == @item.user_id
    redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def form_params
    params.require(:form).permit(:postal_code, :area_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: form_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
