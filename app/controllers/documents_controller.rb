# frozen_string_literal: true

# Controller to perform eForm CRUD
class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy export]

  def index
    @documents = current_user.documents
  end

  def show; end

  def new
    @document = Document.new
  end

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
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to document_url(@document), notice: I18n.t('EForm.Messages.Success.Updated') }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: I18n.t('EForm.Messages.Success.Deleted') }
      format.json { head :no_content }
    end
  end

  def export
    if params[:from].present?
      email_me_the_document(@document) if params[:from] == 'email'
      redirect_to generate_pdf_document_path(permit_params_for_pdf) if params[:from] == 'download'
    end
  end

  def generate_pdf
    set_document
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: (DateTime.now + @document.id).to_s
      end
    end
  end

  private

  def email_me_the_document(document)
    UserMailer.send_me_document(document).deliver_now!
    redirect_to documents_path
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :user_id)
  end

  def permit_params_for_pdf
    params.permit(:id, :format).to_h
  end
end
