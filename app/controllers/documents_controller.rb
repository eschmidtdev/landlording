# frozen_string_literal: true

# Controller to perform eForm CRUD
class DocumentsController < ApplicationController
  before_action :set_e_form, only: %i[show edit update destroy]

  def index
    @documents = current_user.documents
  end

  def show; end

  def new
    @document = Document.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def create
    @document = Document.new(e_form_params)
    @document.user_id = current_user.id

    respond_to do |format|
      if @document.save
        format.html { redirect_to document_url(@document), notice: I18n.t('EForm.Messages.Success.Created') }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def update
    respond_to do |format|
      if @document.update(e_form_params)
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

  private

  def set_e_form
    @document = Document.find(params[:id])
  end

  def e_form_params
    params.require(:e_form).permit(:name, :user_id)
  end
end
