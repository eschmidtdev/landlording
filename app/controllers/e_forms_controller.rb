# frozen_string_literal: true

# Controller to perform eForm CRUD
class EFormsController < ApplicationController
  before_action :set_e_form, only: %i[show edit update destroy]

  def index
    @e_forms = current_user.e_forms
  end

  def show; end

  def new
    @e_form = EForm.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def create
    @e_form = EForm.new(e_form_params)
    @e_form.user_id = current_user.id

    respond_to do |format|
      if @e_form.save
        format.html { redirect_to e_form_url(@e_form), notice: I18n.t('EForm.Messages.Success.Created') }
        format.json { render :show, status: :created, location: @e_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @e_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def update
    respond_to do |format|
      if @e_form.update(e_form_params)
        format.html { redirect_to e_form_url(@e_form), notice: I18n.t('EForm.Messages.Success.Updated') }
        format.json { render :show, status: :ok, location: @e_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @e_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @e_form.destroy

    respond_to do |format|
      format.html { redirect_to e_forms_url, notice: I18n.t('EForm.Messages.Success.Deleted') }
      format.json { head :no_content }
    end
  end

  private

  def set_e_form
    @e_form = EForm.find(params[:id])
  end

  def e_form_params
    params.require(:e_form).permit(:name, :user_id)
  end
end
