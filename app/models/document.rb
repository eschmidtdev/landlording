# frozen_string_literal: true

class Document < ApplicationRecord
  # Association
  belongs_to :user

  self.per_page = 5
end
