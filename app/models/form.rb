class Form
  attr_accessor :token, :user_id, :item_id, :postal_code, :area_id, :municipality, :house_number, :building_name, :phone_number, :order_id

  include ActiveModel::Model

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ ,message: 'はハイフンを入れて入力してください'}
    validates :area_id, numericality: { other_than: 1,message: 'を選択してください' }
    validates :municipality
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/,message: 'は10桁または11桁でハイフンなしで入力してください'}
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
