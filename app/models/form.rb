class order_form
  include ActiveModel::Model
  attr_accessor :user, :item, :postal_code, :area_id, :municipality, :house_number, :building_name, :phone_number, :order

  with_options presence: true do
    validates :user
    validates :item
    validates :postal_code
    validates :area_id
    validates :municipality
    validates :house_number
    validates :building_name
    validates :phone_number
    validates :order
  end

  def save
    Order.create(:user, :item)
    Address.create(:postal_code, :area_id, :municipality, :house_number, :building_name, :phone_number, :order)
  end
end