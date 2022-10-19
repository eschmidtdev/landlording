# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(User, type: :model) do

  describe 'Associations' do
    context "The 'have_one' matcher" do
      it { should have_one(:subscription).dependent(:destroy) }
      it { should have_one(:payment_detail).dependent(:destroy) }
    end

    context "The 'have_many' matcher" do
      it { should have_many(:documents).dependent(:destroy) }
      it { should have_many(:properties).dependent(:destroy) }
    end
  end

  describe 'Activerecord Callbacks' do
    it { is_expected.to(callback(:normalize_phone).before(:save)) }
    it { is_expected.to(callback(:transact_service).after(:create)) }
    it { is_expected.to(callback(:update_confirmed_at).after(:create)) }
    it { is_expected.to(callback(:send_change_password_email).after(:create)) }
  end

  describe 'Instance Methods' do
    it 'Should test not_confirmed? & return true' do
      user = User.new(confirmed_at: nil)
      response = user.not_confirmed?
      expect(response).to(be_truthy)
    end
  end

  describe 'Private Methods/Activerecord::Callbacks' do
    let(:user) { create(:user) }
    context 'While Testing Subscription Association' do
      it 'Should return true/ActiveRecord::Object' do
        expect(user.subscription).not_to(be_falsey)
      end
    end

    context 'While Testing PaymentDetail Association' do
      it 'Should return true/ActiveRecord::Object' do
        expect(user.payment_detail).not_to(be_falsey)
      end
    end

    context 'While Testing normalize_phone Method/Activerecord::Callbacks' do
      it 'Should return phone number with + format' do
        expect(user.phone_number).to(eq('+555551115555'))
      end
    end

    context 'While Testing update_confirmed_at Method/Activerecord::Callbacks' do
      it "Should Return 'true' After Update" do
        expect(user.confirmed_at).not_to(be_falsey)
      end
    end
  end
end
