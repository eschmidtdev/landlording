# frozen_string_literal: true

module Rocket
  class DeleteInterviewService < ApplicationService
    attr_reader :interview_id, :access_token

    def initialize(interview_id, access_token)
      @interview_id = interview_id
      @access_token = access_token
    end

    def call
      delete_interview
    end

    def delete_interview
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/rocketdoc/v1/interviews/#{interview_id}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Delete.new(url)
      request['Authorization'] = "Bearer #{access_token}"

      response = https.request(request)
      return nil unless response.code == '204'

      success_response('Document has been deleted successfully')
    end
  end
end
