class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :name
    validates :text
    with_options numericality: { other_than: 1, message: 'を選択してください'  } do
      validates :category_id
      validates :condition_id
      validates :burden_id
      validates :area_id
      validates :day_id
    end
    PRICE_REGEX = /\A[0-9]+\z/.freeze
    validates :price,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999
              },
              format: { with: PRICE_REGEX }
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :burden
  belongs_to_active_hash :area
  belongs_to_active_hash :day

  belongs_to :user
  has_one :order
  has_one_attached :image
end
