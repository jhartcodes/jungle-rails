require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 
    context 'Can save a new user successfully' do
      it 'after saving, the new user should exist in db' do
        @user = User.create(first_name: 'testUser', last_name:'testLast', email: 'email@test.com', password: 'password', password_confirmation: 'password')
        expect(User.find_by(first_name: 'testUser').first_name).to eq 'testUser'
      end
    end
    context 'When saving a new user' do
      it "should return 'First name can't be blank' if theres no first_name" do
        @user = User.create(first_name: nil, last_name:'testLast', email: 'email@test.com', password: 'password', password_confirmation: 'password')
        expect(@user.errors.full_messages[0]).to eq "First name can't be blank"
      end
      it "should return 'Last name can't be blank' if theres no last_name" do
        @user = User.create(first_name: 'testUser', last_name: nil, email: 'email@test.com', password: 'password', password_confirmation: 'password')
        expect(@user.errors.full_messages[0]).to eq "Last name can't be blank"
      end
      it "should return 'Email can't be blank' if theres no email" do
        @user = User.create(first_name: 'testUser', last_name: 'lastName', email: nil, password: 'password', password_confirmation: 'password')
        expect(@user.errors.full_messages[0]).to eq "Email can't be blank"
      end
      it "should return 'Password confirmation doesn't match Password' if passwords don't match" do
        @user = User.create(first_name: 'testUser', last_name: 'lastName', email: 'email@email.com', password: 'password', password_confirmation: 'passwor')
        expect(@user.errors.full_messages[0]).to eq "Password confirmation doesn't match Password"
      end
      it "should return 'Email has already been taken' if email already exists in DB" do
        @user1 = User.create(first_name: 'testUser1', last_name: 'lastName1', email: 'email@email.com', password: 'password1', password_confirmation: 'password1')
        @user = User.create(first_name: 'testUser', last_name: 'lastName', email: 'emAiL@email.com', password: 'password', password_confirmation: 'password')
        expect(@user.errors.full_messages[0]).to eq "Email has already been taken"
      end
      it "should return 'Password is too short (minimum is 5 characters)' if password is less than 5 characters" do
        @user = User.create(first_name: 'testUser', last_name: 'lastName', email: 'email@email.com', password: 'pass', password_confirmation: 'pass')
        puts @user.errors.full_messages
        expect(@user.errors.full_messages[0]).to eq "Password is too short (minimum is 5 characters)"
      end
    end
  end
  describe '.authenticate_with_credentials' do
    context 'when the user signs in' do
      it 'should still let them login if there are spaces typed before or after the email' do
        @user = User.create(first_name: 'testUser', last_name: 'lastName', email: '  email@email.com   ', password: 'password', password_confirmation: 'password')
        expect(User.find_by(first_name: 'testUser').first_name).to eq 'testUser'
      end
      it 'should still let them login if there are uppercase characters typed in the email' do
        @user = User.create(first_name: 'testUser', last_name: 'lastName', email: 'eMAil@eMail.com', password: 'password', password_confirmation: 'password')
        expect(User.find_by(first_name: 'testUser').first_name).to eq 'testUser'
      end
    end
  end
end