# frozen_string_literal: true

module Documents
  class CreateDocumentService < ApplicationService
    attr_accessor :interview_id, :user

    def initialize(interview_id, user)
      @user         = user
      @interview_id = interview_id
    end

    def call
      create_document
    end

    private

    def create_document
      document = Document.create!(name: 'Testing Document', user_id: user.id, interview_id:)
      document.attributes
    end
  end
end
