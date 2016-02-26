module SubscriptionsHelper

  def plan_gets_tee_shirt(plan)
    plan[:benefits].include?("T-Shirt")
  end

  def plan_gets_polo(plan)
    plan[:benefits].include?("Polo")
  end

  def plan_gets_hoodie(plan)
    plan[:benefits].include?("Hoodie") ||
      plan[:benefits].include?("plus Champion")
  end
end
