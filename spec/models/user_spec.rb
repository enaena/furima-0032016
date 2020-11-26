require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英数字混合でなければ登録できない' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードが全角では登録できない' do
        @user.password = 'AAA１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードが存在してもパスワード(確認用)が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@を含んでいない場合は登録できない' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'ユーザー本名(名字)が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名(名前)が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名(名字)が全角(漢字・ひらがな・カタカナ)でなければ登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end
      it 'ユーザー本名(名前)が全角(漢字・ひらがな・カタカナ)でなければ登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it 'ユーザー本名のフリガナ(名字)が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナ(名前)が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナ(名字)が全角(カタカナ)でなければ登録できない' do
        @user.last_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角(カタカナ)文字を使用してください')
      end
      it 'ユーザー本名のフリガナ(名前)が全角(カタカナ)でなければ登録できない' do
        @user.first_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角(カタカナ)文字を使用してください')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
