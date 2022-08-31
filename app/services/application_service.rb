# frozen_string_literal: true

# A base class ApplicationService that our service objects will inherit from
class ApplicationService

  require 'uri'
  require 'json'
  require 'net/http'

  def self.call(*args, &)
    new(*args, &).call
  end

  MESSAGES = {
    missing_params: I18n.t('GeneralError.ParamsMissing'),
    add_phone: I18n.t('Properties.AddPhone'),
    went_wrong: I18n.t('GeneralError.WentWrong'),
    add_email: I18n.t('Properties.AddEmail'),
    add_name: I18n.t('Properties.AddName')
  }.freeze

  def error_response(message) = { success: false, message: }

end
