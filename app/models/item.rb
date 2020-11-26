class Item < ApplicationRecord

  validates :image, presence: true
  validates :name, presence: true
  validates :text, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :burden, presence: true
  validates :area, presence: true
  validates :day, presence: true
  validates :price, presence: true

  validates_inclusion_of :price, in:300..9999999

  VALID_PASSWORD_REGIX = /\A[a-z0-9]+\z/i
  validates :price, format: { with: VALID_PASSWORD_REGIX }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :burden
  belongs_to_active_hash :area
  belongs_to_active_hash :day

  belongs_to :user
  has_one_attached :image
  
end
