require 'rails_helper'
describe Form do
  before do
    @form = FactoryBot.build(:form)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it '全ての項目が存在すれば出品ができる' do
        expect(@form).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it '郵便番号が空では出品できない' do
        @form.postal_code = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがなければ出品できない' do
        @form.postal_code = '0000000'
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が空では出品できない' do
        @form.area_id = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Area can't be blank")
      end
      it '都道府県が1では出品できない' do
        @form.area_id = 1
        @form.valid?
        expect(@form.errors.full_messages).to include("Area must be other than 1")
      end
      it '市区町村が空では出品できない' do
        @form.municipality = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空では出品できない' do
        @form.house_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空では出品できない' do
        @form.phone_number  = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @form.token = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end