# frozen_string_literal: true

module SubscriptionsHelper
  def process_plan(user)
    plan_heading(user) if user.subscription.present?
  end

  private

  def plan_heading(user)
    subscription_plans = {
      'premium_trail' => { name: 'Trial', description: },
      'premium_annual' => { name: 'Annual Plan', description: },
      'premium_monthly' => { name: 'Monthly Plan', description: },
      'free' => { name: 'Free Account', description: free_description }
    }

    subscription_plans[user.subscription&.plan]
  end

  def free_description
    'Limited access to our legal document library and online rental application tool,
     Free account.'
  end

  def description
    'Unlimited access to our legal document library, online document storage and digital
     signing feature.'
  end
end
