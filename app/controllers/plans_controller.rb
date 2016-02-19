class PlansController < ApplicationController
  def index
    @plan_bases = Plan.plan_bases
  end
end
