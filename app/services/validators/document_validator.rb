# frozen_string_literal: true

module Validators
  class DocumentValidator < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = HashWithIndifferentAccess.new(params)
    end

    def call
      missing_params?
    end

    private

    def missing_params?
      error_response('Params missing or values are empty') if !required_keys.all? { |s| params.key?(s) } || params.values.any?(&:blank?)
    end

    def required_keys = %i[name]
  end
end
