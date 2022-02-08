require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      email: 'example@ex.com',
      first_name: 'John',
      last_name: 'Jones',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )
  end
  let(:no_email_user) do
    User.new(
      email: nil,
      first_name: 'John',
      last_name: 'Jones',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )
  end
  let(:no_first_name_user) do
    User.new(
      email: 'example@ex.com',
      first_name: nil,
      last_name: 'Jones',
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )
  end
  let(:no_last_name_user) do
    User.new(
      email: 'example@ex.com',
      first_name: 'John',
      last_name: nil,
      password: 'abcd1234',
      password_confirmation: 'abcd1234'
    )
  end
  let(:no_password_user) do
    User.new(
      email: 'example@ex.com',
      first_name: 'John',
      last_name: 'Jones',
      password: nil,
      password_confirmation: 'abcd1234'
    )
  end
  let(:no_password_confirm_user) do
    User.new(
      email: 'example@ex.com',
      first_name: 'John',
      last_name: 'Jones',
      password: 'abcd1234',
      password_confirmation: nil
    )
  end
  let(:diff_password_user) do
    User.new(
      email: 'example@ex.com',
      first_name: 'John',
      last_name: 'Jones',
      password: 'abcd1234',
      password_confirmation: 'ABff1234'
    )
  end
  let(:short_password_user) do
    User.new(
      email: 'example@ex.com',
      first_name: 'John',
      last_name: 'Jones',
      password: 'abcd',
      password_confirmation: 'abcd'
    )
  end
  describe 'Validations' do
    it 'should create the user when required fields are set' do
      expect(user).to be_valid
    end
    it 'should not create user without an email' do
      expect(no_email_user).to_not be_valid
    end
    it 'should not create user without a first_name' do
      expect(no_first_name_user).to_not be_valid
    end
    it 'should not create user without a last_name' do
      expect(no_last_name_user).to_not be_valid
    end
    it 'should not create user without a password' do
      expect(no_password_user).to_not be_valid
    end
    it 'should not create user without a password cofirmation' do
      expect(no_password_confirm_user).to_not be_valid
    end
    it "should not be valid when password and password_confirmation don't match" do
      expect(diff_password_user).to_not be_valid
    end
    it 'should not create user if email exist in database (not case sensitive' do
      user.save

      same_user = User.create(
        email: 'exaMPle@ex.com',
        first_name: 'Johntwo',
        last_name: 'Jonestwo',
        password: 'abcd1234',
        password_confirmation: 'abcd1234'
      )
      expect(same_user).to_not be_valid
    end
    it 'should have at least 6 digits password' do
      expect(short_password_user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with correct email and password' do
      user.save!
      vaild_user = User.authenticate_with_credentials('example@ex.com', 'abcd1234')

      expect(vaild_user).to eq(user)
    end
    it 'should not authenticate if email/password are not match' do
      user.save
      wrong_user = User.authenticate_with_credentials('wrong@wrong.com', 'password')
      expect(wrong_user).to eq(nil)
    end
    it 'should remove whitespace when email contains it' do
      user.save!
      misstyped_user = User.authenticate_with_credentials('    example@ex.com     ', 'abcd1234')

      expect(misstyped_user).to eq(user)
    end
    it 'should remove whitespace when email contains it' do
      user.save!
      capslock_user = User.authenticate_with_credentials('example@EX.com', 'abcd1234')

      expect(capslock_user).to eq(user)
    end
  end
end
