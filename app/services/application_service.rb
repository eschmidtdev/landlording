# frozen_string_literal: true

# A base class ApplicationService that our service objects will inherit from
class ApplicationService

  require 'uri'
  require 'json'
  require 'net/http'

  def self.call(*args, &)
    new(*args, &).call
  end

end
