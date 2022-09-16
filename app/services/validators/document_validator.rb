# frozen_string_literal: true

module Validators
  class DocumentValidator < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = HashWithIndifferentAccess.new params
    end

    def call
      missing_params?
    end

    private

    def missing_params?
      if !required_keys.all? { |s| params.key? s } || params.values.any?(&:blank?)
        error_response('Params missing or values are empty')
      end
    end

    def required_keys = %i[name]

  end
end
