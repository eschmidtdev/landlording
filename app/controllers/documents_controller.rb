# frozen_string_literal: true

# Controller to perform Document CRUD
# rubocop:disable Metrics/ClassLength
class DocumentsController < ApplicationController
  require 'json'
  require 'open-uri'
  before_action :set_document, only: %i[show edit update destroy export generate_pdf]

  def index
    @documents = current_user.documents
  end

  def show; end

  # rubocop:disable Metrics/Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def new
    access_token_response = execute_access_token_request
    unless access_token_response.code == '200'
      return redirect_to documents_url,
                         notice: I18n.t('EForm.Messages.Error.WentWrong')
    end

    access_token_data = JSON.parse(access_token_response.body)
    interview_response = execute_interview_request(access_token_data)
    unless interview_response.code == '201'
      return redirect_to documents_url,
                         notice: I18n.t('EForm.Messages.Error.WentWrong')
    end

    interview_data = JSON.parse(interview_response.body)
    @interview_id = interview_data['interviewId']
    @service_token = interview_response.each_header.to_h['rl-rdoc-servicetoken']
  end
  # rubocop:enable Metrics/Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def edit; end

  def create
    @document = Document.new(document_params)
    @document.user_id = current_user.id

    if @document.save
      redirect_to documents_url, notice: I18n.t('EForm.Messages.Success.Created')
    else
      redirect_to documents_url
    end
  end

  def update
    return unless @document.update(document_params)
    return render json: { status: 200, message: I18n.t('EForm.Messages.Success.Updated') } if request.xhr?

    redirect_to documents_path, notice: I18n.t('EForm.Messages.Success.Updated')
  end

  def destroy
    @document.destroy

    redirect_to documents_url, notice: I18n.t('EForm.Messages.Success.Deleted')
  end

  def export
    return unless params[:from].present?

    email_me_the_document(@document) if params[:from] == 'email'
    redirect_to generate_pdf_document_path(pdf_params) if params[:from] == 'download' || params[:from] == 'print'
  end

  def generate_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: (DateTime.now + @document.id).to_s
      end
    end
  end

  def execute_access_token_request
    make_request(ENV['ACCESS_TOKEN_URL'], request_header, access_request_body)
  end

  def execute_interview_request(response)
    headers = request_header.merge({ 'Authorization' => "Bearer #{response['access_token']}" })
    make_request(ENV['INTERVIEW_URL'], headers, interview_request_body)
  end

  def request_header
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  def make_request(uri, headers = {}, body = nil, type = 'Post')
    uri = URI.parse(uri.to_s)
    request = "Net::HTTP::#{type}".constantize.new(uri)
    headers.each_with_object(request) do |(k, v), req|
      req[k] = v
    end
    request.content_type = 'application/json'
    request.body = body.to_json unless body.nil?
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
  end

  private

  def email_me_the_document(document)
    UserMailer.send_me_document(document).deliver_now!
    redirect_to documents_path, notice: I18n.t('EForm.Messages.Success.EmailSent')
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :user_id)
  end

  def pdf_params
    params.permit(:id, :format).to_h
  end

  def access_request_body
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      grant_type: ENV['CLIENT_CREDENTIALS']
    }
  end

  def interview_request_body
    {
      templateId: '04d9d0ba-3113-40d3-9a4e-e7b226a72154',
      partyEmailAddress: current_user.email,
      partnerEndUserId: current_user.id
    }
  end
end
# rubocop:enable Metrics/ClassLength
