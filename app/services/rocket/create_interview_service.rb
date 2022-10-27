# frozen_string_literal: true

module Rocket
  class CreateInterviewService < ApplicationService
    attr_reader :access_token, :user

    def initialize(access_token, user)
      @user         = user
      @access_token = access_token
    end

    def call
      create_interview
    end

    private

    def create_interview
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/rocketdoc/v1/interviews")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['Authorization'] = "Bearer #{access_token}"
      request['Content-Type'] = 'application/json'
      request.body = JSON.dump({
        partnerEndUserId: user.uuid,
        partyEmailAddress: user.email,
        templateId: '04d9d0ba-3113-40d3-9a4e-e7b226a72154'
      }
                              )

      response = https.request(request)
      return nil unless response.code == '201'

      data = construct_hash(response)
      HashWithIndifferentAccess.new(data)
    end

    def construct_hash(response)
      {
        interview_id: JSON.parse(response.read_body)['interviewId'],
        service_token: response.each_header.to_h['rl-rdoc-servicetoken']
      }
    end
  end
end
