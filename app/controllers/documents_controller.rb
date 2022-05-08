# frozen_string_literal: true

# Controller to perform Document CRUD
class DocumentsController < ApplicationController
  require 'json'
  require 'open-uri'
  before_action :set_document, only: %i[show edit update destroy export generate_pdf]

  def index
    @documents = current_user.documents
  end

  def new
    access_token_response = execute_access_token_request
    redirect_url(access_token_response, '200')
    access_token_data = JSON.parse(access_token_response.body)

    interview_response = execute_interview_request(access_token_data)
    unless interview_response.code == '201'
      return redirect_to documents_url,
                         notice: I18n.t('EForm.Messages.Error.WentWrong')
    end

    service_token_response = execute_service_token_request(access_token_data)
    unless service_token_response.code == '200'
      return redirect_to documents_url,
                         notice: I18n.t('EForm.Messages.Error.WentWrong')
    end

    service_token_data = JSON.parse(service_token_response.body)
    @service_token = service_token_data['token']

    interview_data = JSON.parse(interview_response.body)
    @interview_id = interview_data['interviewId']
    @rl_rdoc_service_token = interview_response.each_header.to_h['rl-rdoc-servicetoken']

    # Integrating with RocketSign
    access_binder_response = execute_binder_request(@interview_id, access_token_data)
    unless access_binder_response.code == '200'
      return redirect_to documents_url,
                         notice: I18n.t('EForm.Messages.Error.WentWrong')
    end

    binder_data = JSON.parse(access_binder_response.body)
    @binder_id = binder_data.dig('binder', 'binderId')
    @document_id = binder_data.dig('binder', 'documentId')
  end

  def export
    return unless params[:from].present?

    email_me_the_document(@document) if params[:from] == 'email'
    if params[:from] == 'download' || params[:from] == 'print'
      redirect_to generate_pdf_document_path(pdf_params)
    end
  end

  def generate_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: (DateTime.now + @document.id).to_s
      end
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def execute_access_token_request
    make_request(ENV.fetch('ACCESS_TOKEN_URL', nil), request_header, access_request_body,
                 'Post')
  end

  def execute_interview_request(response)
    headers = request_header.merge({ Authorization: "Bearer #{response['access_token']}" })
    make_request(ENV.fetch('INTERVIEW_URL', nil), headers, interview_request_body, 'Post')
  end

  def execute_service_token_request(response)
    headers = request_header.merge({ Authorization: "Bearer #{response['access_token']}" })
    make_request('https://api-sandbox.rocketlawyer.com/partners/v1/auth/servicetoken',
                 headers, service_token_body, 'Post')
  end

  def execute_binder_request(interview_id, response)
    headers = { Authorization: "Bearer #{response['access_token']}" }
    make_request(
      "https://api-sandbox.rocketlawyer.com/rocketdoc/v1/interviews/#{interview_id}", headers, nil, 'Get'
    )
  end

  def make_request(uri, headers = {}, body = nil, type)
    uri = URI.parse(uri.to_s)
    request = "Net::HTTP::#{type}".constantize.new(uri)
    headers.each_with_object(request) do |(k, v), req|
      req[k] = v
    end
    # request.content_type = 'application/json'
    request.body = body.to_json unless body.nil?
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def email_me_the_document(document)
    UserMailer.send_me_document(document).deliver_now!
    redirect_to documents_path, notice: I18n.t('EForm.Messages.Success.EmailSent')
  end

  def pdf_params
    params.permit(:id, :format).to_h
  end

  def access_request_body
    {
      client_id: ENV.fetch('CLIENT_ID', nil),
      client_secret: ENV.fetch('CLIENT_SECRET', nil),
      grant_type: ENV.fetch('CLIENT_CREDENTIALS', nil)
    }
  end

  def interview_request_body
    {
      templateId: '04d9d0ba-3113-40d3-9a4e-e7b226a72154',
      partyEmailAddress: current_user.email,
      partnerEndUserId: current_user.id
    }
  end

  def service_token_body
    {
      purpose: 'api.rocketlawyer.com/document-manager/v1/binders',
      expirationTime: 160780393200,
      upid: '9b713671-3b19-470e-85b6-191f2fc09a7a'
    }
  end

  def request_header
    {
      'Content-Type' => 'application/json',
      Accept: 'application/json'
    }
  end

  def redirect_url(response, code)
    unless response.code == code
      redirect_to documents_url,
                  notice: I18n.t('EForm.Messages.Error.WentWrong')
    end
  end
end
