module SubscriptionsHelper

  def check_for(value)
    value.present? ? value : ''
  end

end
