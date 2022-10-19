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
end
