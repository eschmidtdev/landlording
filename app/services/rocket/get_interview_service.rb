# frozen_string_literal: true

module Rocket
  class GetInterviewService < ApplicationService
    attr_reader :access_token, :interview_id

    def initialize(access_token, interview_id)
      @interview_id = interview_id
      @access_token = access_token
    end

    def call
      get_interview
    end

    private

    def get_interview
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/rocketdoc/v1/interviews/#{interview_id}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['Authorization'] = "Bearer #{access_token}"

      response = https.request(request)
      return nil unless response.code == '200'

      JSON.parse(response.read_body)
    end

  end
end
