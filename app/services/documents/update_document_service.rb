# frozen_string_literal: true

module Documents
  class UpdateDocumentService < ApplicationService
    attr_reader :document, :name

    def initialize(document, params)
      @document = document
      @name     = params[:document][:name]
    end

    def call
      update_document
    end

    private

    def update_document
      return success_response('Document has been updated successfully.') if document.update(name:)

      error_response('Document has not been updated successfully.')
    end
  end
end
