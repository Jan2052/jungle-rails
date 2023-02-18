require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do

    it 'valid when required user fields are present and passwords match' do
      user = User.new(
        name: 'Hello',
        email: 'World@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'fails when password and password_confirmation do not match' do
      user = User.new(
        name: 'Hello',
        email: 'World@gmail.com',
        password: 'password',
        password_confirmation: 'different'
      )
      expect(user).not_to be_valid
    end

    it 'fails when a field is missing' do
      user = User.new(
        name: 'Hello',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    context 'fails when email is not unique and not case sensitive' do
      before do
        User.create(
          name: 'Hello',
          email: 'world@gmail.com',
          password: 'password',
          password_confirmation: 'password'
        )
      end
    
      it 'should not be valid' do
        user = User.new(
          name: 'Hello',
          email: 'WORLD@gmail.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).not_to be_valid
      end
    end

    it 'fails when password minimum length < 8' do
      user = User.new(
        name: 'Hello',
        email: 'world@gmail.com',
        password: '1234567',
        password_confirmation: '1234567'
      )
      expect(user).not_to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        name: 'Hello',
        email: '123@123.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it 'authenticates with correct credentials' do
      authenticated_user = User.authenticate_with_credentials('123@123.com', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'does not authenticate with incorrect email' do
      authenticated_user = User.authenticate_with_credentials('wrong@email.com', 'password123')
      expect(authenticated_user).to be_nil
    end

    it 'does not authenticate with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('123@123.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates with leading/trailing white space in email' do
      authenticated_user = User.authenticate_with_credentials(' 123@123.com ', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    it 'authenticates with wrong case in email' do
      authenticated_user = User.authenticate_with_credentials('123@123.COM', 'password123')
      expect(authenticated_user).to eq(@user)
    end
  end
end
