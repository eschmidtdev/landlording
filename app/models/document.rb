# frozen_string_literal: true

class Document < ApplicationRecord
  # Association
  belongs_to :user

  # Enums
  enum status: { in_progress: 0,
                 signed: 1,
                 completed: 2,
                 ready_to_sign: 3,
                 waiting_for_signature: 4
  }

  self.per_page = 5
end
