# frozen_string_literal: true

module Rocket
  class RetrieveDocumentService < ApplicationService
    attr_reader :binder_id, :document_id, :access_token

    def initialize(binder_id, document_id, access_token)
      @binder_id    = binder_id
      @document_id  = document_id
      @access_token = access_token
    end

    def call
      create_retrieval_request
    end

    private

    def create_retrieval_request
      url = URI("#{ENV.fetch('ROCKET_BASE_URL', nil)}/document-manager/v1/binders/#{binder_id}/documents/#{document_id}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['Accept'] = 'text/html'
      request['Authorization'] = "Bearer #{access_token}"

      response = https.request(request)
      return nil unless response.code == '303'

      data = construct_hash(response)
      HashWithIndifferentAccess.new(data)
    end

    def construct_hash(response)
      {
        url: response.each_header.to_h['location']
      }
    end
  end
end
