# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: :create_interview
  before_action :set_document, only: %i[update delete validate_document]
  before_action :validate_document, only: :update

  include Responseable

  require 'uri'
  require 'json'
  require 'net/http'

  def index
    @documents = Document.user_documents(current_user.id).paginate(page: params[:page]).order('id DESC')
  end

  def update
    resp = Documents::UpdateDocumentService.call(@document, params)
    render_message(resp)

    redirect_to(documents_url)
  end

  def delete
    resp = Documents::DeleteDocumentService.call(@document)
    render_message(resp)

    redirect_to(documents_url)
  end

  def create_interview
    access_token_response = Rocket::GenerateAccessTokenService.call
    return redirect_to(documents_url) if access_token_response.nil?

    @access_token = access_token_response['access_token']
    interview_response = Rocket::CreateInterviewService.call(@access_token, current_user)
    return redirect_to(documents_url) if interview_response.nil?

    @rl_rdoc_service_token = interview_response['service_token']
    @interview_id = interview_response['interview_id']

    Documents::CreateDocumentService.call(@interview_id, current_user)
  end

  def complete_interview
    completion_response = Rocket::CompleteInterviewService.call(params[:interview_id], params[:access_token])
    return redirect_to(documents_url) if completion_response.nil?

    @binder_id = completion_response['binder_id']
    @document_id = completion_response['document_id']

    retrieval_response = Rocket::RetrieveDocumentService.call(@binder_id, @document_id, params[:access_token])
    return redirect_to(documents_url) if retrieval_response.nil?

    @url = retrieval_response['url']
  end

  def sign_document
    interview_response = Rocket::GetInterviewService.call(params[:access_token], params[:interview_id])
    return redirect_to(documents_url) if interview_response.nil?

    binder_id = interview_response['binder']['binderId']

    upid_response = Rocket::GetUpidService.call(params[:access_token], binder_id)
    return redirect_to(documents_url) if upid_response.nil?

    upid = upid_response['parties'].first['id']

    service_token_response = Rocket::GenerateServiceTokenService.call(params[:access_token], upid)
    return redirect_to(documents_url) if service_token_response.nil?

    service_token = service_token_response['token']

    @url = "https://document-manager.sandbox.rocketlawyer.com/#{binder_id}#serviceToken=#{service_token}"
  end

  # def export
  #   return unless params[:from].present?
  #
  #   email_me_the_document(@document) if params[:from] == 'email'
  #   return unless params[:from] == 'download' || params[:from] == 'print'
  #
  #   redirect_to generate_pdf_document_path(pdf_params)
  # end

  # def generate_pdf
  #   respond_to do |format|
  #     format.html
  #     format.pdf do
  #       render pdf: (DateTime.now + @document.id).to_s
  #     end
  #   end
  # end

  private

  def pdf_params = params.permit(:id, :format).to_h

  def set_document = @document = Document.find(params[:id])

  def permitted_params = params.require(:document).permit(:name)

  # def email_me_the_document(document)
  #   UserMailer.send_me_document(document).deliver_now!
  #   redirect_to(documents_path, notice: 'Email sent')
  # end

  def validate_document
    resp = Validators::DocumentValidator.call(permitted_params)
    return if resp.nil?

    render_message(resp)
    redirect_to(documents_url)
  end
end
