# frozen_string_literal: true

module Rocket
  class CompleteInterviewService < ApplicationService
    attr_reader :interview_id, :access_token

    def initialize(interview_id, access_token)
      @access_token = access_token
      @interview_id = interview_id
    end

    def call
      create_completion_request
    end

    private

    def create_completion_request
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/rocketdoc/v1/interviews/#{interview_id}/completions")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['Authorization'] = "Bearer #{access_token}"

      response = https.request(request)
      return nil unless response.code == '201'

      data = construct_hash(JSON.parse(response.read_body))
      HashWithIndifferentAccess.new data
    end

    def construct_hash(response)
      {
        binder_id: response['binder']['binderId'],
        document_id: response['binder']['documentId']
      }
    end

  end
end
