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
end
