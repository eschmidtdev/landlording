# frozen_string_literal: true

module Rocket
  class GenerateServiceTokenService < ApplicationService
    attr_reader :access_token, :uipd

    def initialize(access_token, uipd)
      @uipd         = uipd
      @access_token = access_token
    end

    def call
      generate_service_token
    end

    private

    def generate_service_token
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/partners/v1/auth/servicetoken")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{access_token}"
      request["Content-Type"]  = 'application/json'
      request.body = JSON.dump({
                                 purpose: 'api.rocketlawyer.com/document-manager/v1/binders',
                                 expirationTime: 160780393200,
                                 upid: uipd
                               })

      response = https.request(request)
      return nil unless response.code == '200'

      JSON.parse(response.read_body)
    end

  end
end
