# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Document, type: :model) do
  describe 'Associations' do
    context "The 'have_one' matcher" do
      it { should belong_to(:user) }
    end
  end

  describe 'Enums' do
    context 'Enum Matcher' do
      it { should define_enum_for(:status) }
    end
  end
end
