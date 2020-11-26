class Item < ApplicationRecord

  validates :name, presence: true
  validates :text, presence: true
  validates :cotegory_id, presence: true
  validates :condition_id, presence: true
  validates :bueden, presence: true
  validates :area, presence: true
  validates :day, presence: true
  validates :price, presence: true

  validates :price, format: { with: /^[a-zA-Z0-9]+$/ }
  validates_inclusion_of :price, in:300..9999999

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  
end
