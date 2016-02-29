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
    plan[:gift].present?
  end
end
