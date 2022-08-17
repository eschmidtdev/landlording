# frozen_string_literal: true

module VisitorsHelper

  def visitor_card_image(index)
    if index.zero?
      image_tag 'visitors/my_doc_icon.svg',
                class: 'card_image pull-left'
      #elsif index == 1
      #image_tag 'visitors/rental_app_icon.svg',
      #class: 'card_image pull-left'
    elsif index == 1
      image_tag 'visitors/my_prop_icon.svg',
                class: 'card_image pull-left'
    elsif index == 2
      image_tag 'visitors/acc_set_icon.svg',
                class: 'card_image pull-left'
    end
  end

  def visitor_card_heading(index)
    if index.zero?
      'My Documents'
      #elsif index == 1
      #'Rental Applications'
    elsif index == 1
      'My Properties'
    elsif index == 2
      'Account Settings'
    end
  end

  def visitor_card_description(index)
    if index.zero?
      'Create, sign and manage lease agreements, notice forms and other documents.'
      #elsif index == 1
      #'Easily screen tenants with our online rental application form.'
    elsif index == 1
      'Save and review information about your rental properties and tenants.'
    elsif index == 2
      'view and edit login, contact info and subscription details.'
    end
  end

  def visitor_card_arrow(index)
    if index.zero?
      image_tag image_path
    elsif [1, 2].include?(index)
      image_tag 'visitors/inactive_arrow.svg'
    end
  end

  def image_path
    if current_page?(root_path)
      'visitors/active_arrow.svg'
    else
      'visitors/inactive_arrow.svg'
    end
  end

  def page_redirection(index)
    case index
    when 0
      documents_path
    when 1
      properties_path
    when 2
      account_path
    end
  end

end
