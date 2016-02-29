class PlansController < ApplicationController
  def index
    @plan_bases = Plan.membership_bases
  end
end
