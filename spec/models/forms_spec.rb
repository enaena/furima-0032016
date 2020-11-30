require 'rails_helper'
describe Form do
  before do
    @form = FactoryBot.build(:form)
  end

  describe '商品購入' do
    context '商品購入がうまくいくとき' do
      it '全ての項目が存在すれば購入ができる' do
        expect(@form).to be_valid
      end
      it '建物番号が空でも購入ができる' do
        @form.building_name = ''
        expect(@form).to be_valid
      end
    end

    context '商品購入がうまくいかないとき' do
      it '郵便番号が空では購入できない' do
        @form.postal_code = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがなければ購入できない' do
        @form.postal_code = '0000000'
        @form.valid?
        expect(@form.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県が空では購入できない' do
        @form.area_id = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Area can't be blank")
      end
      it '都道府県が1では購入できない' do
        @form.area_id = 1
        @form.valid?
        expect(@form.errors.full_messages).to include('Area must be other than 1')
      end
      it '市区町村が空では購入できない' do
        @form.municipality = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空では購入できない' do
        @form.house_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空では購入できない' do
        @form.phone_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると購入できない' do
        @form.phone_number = '000-000-000'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号は11桁以内でないと購入できない' do
        @form.phone_number = '000000000000'
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number is invalid")
      end
      it 'tokenが空では購入できない' do
        @form.token = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
