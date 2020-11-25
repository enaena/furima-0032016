class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])[a-z\d]+\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角文字を使用してください' } do
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :last_name_kana, presence: true
    validates :first_name_kana, presence: true
  end

  validates :birthday, presence: true
end
