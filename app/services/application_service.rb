# frozen_string_literal: true

# A base class ApplicationService that our service objects will inherit from
class ApplicationService
  def self.call(*args, &)
    new(*args, &).call
  end
end
