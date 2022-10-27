# frozen_string_literal: true

# A base class ApplicationService that our service objects will inherit from
class ApplicationService
  require 'uri'
  require 'json'
  require 'net/http'

  def self.call(...)
    new(...).call
  end

  def error_response(message) = { success: false, message: }

  def success_response(message) = { success: true, message: }
end
