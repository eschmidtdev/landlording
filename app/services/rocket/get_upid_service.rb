# frozen_string_literal: true

module Rocket
  class GetUpidService < ApplicationService
    attr_reader :access_token, :binder_id

    def initialize(access_token, binder_id)
      @binder_id    = binder_id
      @access_token = access_token
    end

    def call
      get_upid
    end

    private

    def get_upid
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/document-manager/v1/binders/#{binder_id}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['Accept'] = 'application/json'
      request['Authorization'] = "Bearer #{access_token}"

      response = https.request(request)
      return nil unless response.code == '200'

      JSON.parse(response.read_body)
    end

  end
end
