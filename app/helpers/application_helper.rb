# frozen_string_literal: true

module ApplicationHelper
  def from_e_form_tab?
    current_page?(documents_path) ||
      current_page?(edit_user_registration_path) ||
      current_page?(subscriptions_path) ||
      current_page?(root_path)
  end

  def check_for(value)
    value.present? ? value : ''
  end
end
