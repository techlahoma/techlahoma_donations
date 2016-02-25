module SubscriptionsHelper

  def plan_gets_tee_shirt(plan)
    plan[:benefits].include?("T-Shirt")
  end
end
