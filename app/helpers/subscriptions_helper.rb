module SubscriptionsHelper

  def plan_gets_tee_shirt(plan)
    plan && plan[:gift] && plan[:gift].join(" ").include?("T-Shirt")
  end

  def plan_gets_polo(plan)
    plan && plan[:gift] && plan[:gift].join(" ").include?("Polo")
  end

  def plan_gets_hoodie(plan)
    plan && plan[:gift] && plan[:gift].join(" ").include?("Hoodie")
  end

  def plan_gets_a_gift(plan)
    plan && plan[:gift].present?
  end

  def options_for_subscription_select
    plans = SubscriptionPlan.membership_list
    plan_options = plans.map{|plan| ["#{number_to_currency(plan[:cost_in_dollars])} / #{plan[:interval]}", plan[:id]] }
    selected_plan_id = params[:subscription].present? ? params[:subscription][:stripe_plan_id] : nil
    options_for_select(plan_options, selected_plan_id)
  end

end
