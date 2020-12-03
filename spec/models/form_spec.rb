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
        expect(@form.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号にハイフンがなければ購入できない' do
        @form.postal_code = '0000000'
        @form.valid?
        expect(@form.errors.full_messages).to include('郵便番号はハイフンを入れて入力してください')
      end
      it '都道府県が空では購入できない' do
        @form.area_id = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("都道府県を選択してください")
      end
      it '都道府県が1では購入できない' do
        @form.area_id = 1
        @form.valid?
        expect(@form.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空では購入できない' do
        @form.municipality = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空では購入できない' do
        @form.house_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空では購入できない' do
        @form.phone_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号にハイフンがあると購入できない' do
        @form.phone_number = '000-000-000'
        @form.valid?
        expect(@form.errors.full_messages).to include("電話番号は10桁または11桁でハイフンなしで入力してください")
      end
      it '電話番号は11桁以内でないと購入できない' do
        @form.phone_number = '000000000000'
        @form.valid?
        expect(@form.errors.full_messages).to include("電話番号は10桁または11桁でハイフンなしで入力してください")
      end
      it 'tokenが空では購入できない' do
        @form.token = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
