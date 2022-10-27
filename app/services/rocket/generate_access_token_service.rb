# frozen_string_literal: true

module Rocket
  class GenerateAccessTokenService < ApplicationService
    def call
      generate_access_token
    end

    private

    def generate_access_token
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/partners/v1/auth/accesstoken")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['Content-Type'] = 'application/json'
      request.body = JSON.dump({
        client_id: ENV.fetch('CLIENT_ID', nil),
        client_secret: ENV.fetch('CLIENT_SECRET', nil),
        grant_type: 'client_credentials'
      }
                              )

      response = https.request(request)
      return nil unless response.code == '200'

      JSON.parse(response.read_body)
    end
  end
end
