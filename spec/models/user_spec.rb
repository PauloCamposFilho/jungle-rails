require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with both password and password_confirmation fields' do
      @user = User.new(
        name: 'Some Name',
        email: 'some-email@someplace.com',
        password: 'somepass',
        password_confirmation: 'somepass'
      )
      @user.valid?
      expect(@user).to be_valid
    end

    it 'returns invalid if it is missing the password' do
      @user = User.new(
        name: 'Some Name',
        email: 'some-email@someplace.com',
        # password: 'somepass',
        password_confirmation: 'somepass'
      )
      @user.valid?
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'returns invalid if password and password_confirmation do not match' do
      @user = User.new(
        name: 'Some Name',
        email: 'some-email@someplace.com',
        password: 'somepass',
        password_confirmation: 'not-somepass'
      )
      @user.valid?
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(/doesn't match Password/)
    end

    it 'returns invalid if password is to short' do
      @user = User.new(
        name: 'Some Name',
        email: 'some-email@someplace.com',
        password: 'som',
        password_confirmation: 'som'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include(/is too short/)
    end

    describe 'Validations against existing users' do
      before do
        @user_already_present = User.create(
          name: 'Some Name',
          email: 'some-email@someplace.com',
          password: 'somepass',
          password_confirmation: 'somepass'
        )
      end
      it 'returns invalid if email is already in the database' do
        @user_new = User.new(
          name: 'Some Name',
          email: 'some-email@someplace.com',
          password: 'somepass',
          password_confirmation: 'somepass'
        )
        expect(@user_new).not_to be_valid
        expect(@user_new.errors.full_messages).to include("Email has already been taken")
      end
      it 'returns invalid if user tries to register with different cased existing email' do
        @user_new = User.new(
          name: 'Some Name',
          email: 'SoMe-EmAiL@sOmEPLACe.COm',
          password: 'somepass',
          password_confirmation: 'somepass'
        )
        expect(@user_new).not_to be_valid
        expect(@user_new.errors.full_messages).to include("Email has already been taken")
      end
    end
  end
  describe '.authenticate_with_credentials tests' do
    before do
      @user = User.create(
        name: 'Some Name',
        email: 'some-email@someplace.com',
        password: 'somepass',
        password_confirmation: 'somepass'
      )
    end
    it 'returns user when successfully authenticated' do
      user = User.authenticate_with_credentials('some-email@someplace.com', 'somepass')
      expect(user).to eq(@user)
    end
    it 'returns nil when it cannot authenticate the credentials' do
      user = User.authenticate_with_credentials('some-email@someplace.com', 'somepass1234')
      expect(user).to eq(nil)
    end
    it 'returns user even if different casing is used on the email' do
      user = User.authenticate_with_credentials('sOmE-EMAIL@SoMeplace.coM', 'somepass')
      expect(user).to eq(@user)
    end
    it 'returns user even if there is starting and trailing spaces on the used email' do
      user = User.authenticate_with_credentials('  some-email@someplace.com   ', 'somepass')
      expect(user).to eq(@user)
    end
    it 'returns user even with starting/trailing spaces and different casing' do
      user = User.authenticate_with_credentials('     sOmE-EMAIL@SoMeplace.coM ', 'somepass')
      expect(user).to eq(@user)
    end
  end
end
