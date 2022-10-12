module Documents
  class DeleteDocumentService < ApplicationService
    attr_reader :document

    def initialize(document)
      @document = document
    end

    def call
      delete_from_landlording_db
    end

    def delete_from_landlording_db
      interview_id = document.interview_id
      return delete_from_rocket(interview_id) if document.destroy

      error_response('Document has not been deleted successfully')
    end

    def delete_from_rocket(interview_id)
      access_token_response = Rocket::GenerateAccessTokenService.call

      Rocket::DeleteInterviewService.call(interview_id, access_token_response['access_token'])
    end

  end
end

