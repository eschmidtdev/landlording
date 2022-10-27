# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(AccountSettingsController, type: :request) do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    allow_any_instance_of(ApplicationController).to(receive(:authenticate_user!).and_return(true))
  end

  let(:valid_attributes) do
    {
      sign_in_count: 3,
      last_name: 'User',
      first_name: 'Test',
      password: 'Test@123',
      uuid: SecureRandom.uuid,
      email: Faker::Internet.email
    }
  end

  let(:invalid_attributes) do
    {
      sign_in_count: 3,
      last_name: 'User',
      first_name: 'Testing',
      password: 'Test@123',
      uuid: SecureRandom.uuid,
      email: Faker::Internet.email
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      user = User.create!(valid_attributes)
      login_as(user, scope: :user)
      get '/account'
      expect(response).to(be_successful)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          sign_in_count: 3,
          last_name: 'User',
          first_name: 'Testing',
          password: 'Test@123',
          uuid: SecureRandom.uuid,
          city: Faker::Address.city,
          state: Faker::Address.state,
          email: Faker::Internet.email,
          country: Faker::Address.country,
          company_name: Faker::Company.name,
          postal_code: Faker::Address.postcode,
          address_line_one: Faker::Address.street_address,
          address_line_two: Faker::Address.street_address,
          phone_number: Faker::PhoneNumber.cell_phone_in_e164
        }
      end

      it 'Should updates the requested AccountSetting' do
        user = User.create!(valid_attributes)
        patch "/account_settings/#{user.id}", params: { account_setting: new_attributes, action: 'update' }
      end

      it 'Should redirect to the account path' do
        user = User.create!(valid_attributes)
        patch "/account_settings/#{user.id}", params: { account_setting: new_attributes, action: 'update' }
        user.reload
        expect(response).to(redirect_to(account_path))
      end
    end

    context 'with invalid parameters' do
      it 'Should redirect to the account path' do
        user = User.create!(valid_attributes)
        patch "/account_settings/#{user.id}", params: { account_setting: invalid_attributes, action: 'update' }
        expect(response).to(redirect_to(account_path))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'Should destroy the requested PaymentDetail' do
      user = User.create!(valid_attributes)
      delete "/account_settings/#{user.id}"
    end

    it 'redirects to the widgets list' do
      user = User.create!(valid_attributes)
      delete "/account_settings/#{user.id}"
      expect(response).to(redirect_to(account_path))
    end
  end

  describe 'PUT /change/password' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          new_password: 'Test@124',
          current_password: 'Test@123',
          confirm_password: 'Test@1234'
        }
      end

      it 'Should updates the requested AccountSetting => ChangePassword' do
        user = User.create!(valid_attributes)
        put "/account_settings/#{user.id}/change/password", params: { account_setting: new_attributes, action: 'update_password' }
      end

      it 'Should redirect to the account path' do
        user = User.create!(valid_attributes)
        put "/account_settings/#{user.id}/change/password", params: { account_setting: new_attributes, action: 'update_password' }
        user.reload
        expect(response).to(redirect_to(account_path))
      end
    end

    context 'with invalid parameters' do
      let(:new_attributes) do
        {
          new_password: 'Test@124',
          confirm_password: 'Test@1234'
        }
      end
      it 'Should redirect to the account path' do
        user = User.create!(valid_attributes)
        patch "/account_settings/#{user.id}", params: { account_setting: new_attributes, action: 'update' }
        expect(response).to(redirect_to(account_path))
      end
    end
  end
end
