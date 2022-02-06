class EFormsController < ApplicationController
  before_action :set_e_form, only: %i[ show edit update destroy ]

  # GET /e_forms or /e_forms.json
  def index
    @e_forms = current_user.e_forms
  end

  # GET /e_forms/1 or /e_forms/1.json
  def show
  end

  # GET /e_forms/new
  def new
    @e_form = EForm.new
  end

  # GET /e_forms/1/edit
  def edit
  end

  # POST /e_forms or /e_forms.json
  def create
    @e_form = EForm.new(e_form_params)
    @e_form.user_id = current_user.id

    respond_to do |format|
      if @e_form.save
        format.html { redirect_to e_form_url(@e_form), notice: "E form was successfully created." }
        format.json { render :show, status: :created, location: @e_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @e_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /e_forms/1 or /e_forms/1.json
  def update
    respond_to do |format|
      if @e_form.update(e_form_params)
        format.html { redirect_to e_form_url(@e_form), notice: "E form was successfully updated." }
        format.json { render :show, status: :ok, location: @e_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @e_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /e_forms/1 or /e_forms/1.json
  def destroy
    @e_form.destroy

    respond_to do |format|
      format.html { redirect_to e_forms_url, notice: "E form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_e_form
      @e_form = EForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def e_form_params
      params.require(:e_form).permit(:name, :user_id)
    end
end
