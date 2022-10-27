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
      request['Content-Type'] = 'application/json'
      request.body = JSON.dump({ answersPayload: answer_hash })

      response = https.request(request)
      return nil unless response.code == '201'

      data = construct_hash(JSON.parse(response.read_body))
      HashWithIndifferentAccess.new(data)
    end

    def construct_hash(response)
      {
        binder_id: response['binder']['binderId'],
        document_id: response['binder']['documentId']
      }
    end

    def answer_hash
      {
        Fk8jctrn744ku5: false,
        Fk8jd1no93zprz: '',
        Fk8jd4pfntjpvf: false,
        Fk8jdel8mfwiot: '',
        version: 0
      }
    end
  end
end
