module Documents
  class UpdateDocumentService < ApplicationService
    attr_reader :document, :name

    MESSAGES = {
      updated: 'Document has been updated successfully.',
      not_updated: 'Document has not been updated successfully.'
    }.freeze

    def initialize(document, params)
      @document = document
      @name = params[:document][:name]
    end

    def call
      update_document
    end

    private

    def update_document
      return success_response(MESSAGES[:updated]) if document.update(name: name)

      error_response(MESSAGES[:not_updated])
    end

  end
end
