require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目を入力 かつ 要件を満たせば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = '12345678'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には英字と数字の両方を含めて設定してください"
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name には全角文字を使用してください"
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが全角でないと登録できない' do
        @user.first_name = '2222'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name には全角文字を使用してください"
      end

      it 'last_name_yomiが空では登録できない' do
        @user.last_name_yomi = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name yomi can't be blank")
      end

      it 'last_name_yomiが全角カタカナでないと登録できない' do
        @user.last_name_yomi = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name yomi には全角カタカナを使用してください"
      end

      it 'first_name_yomiが空では登録できない' do
        @user.first_name_yomi = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name yomi can't be blank")
      end

      it 'first_name_yomiが全角カタカナでないと登録できない' do
        @user.first_name_yomi = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name yomi には全角カタカナを使用してください"
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end