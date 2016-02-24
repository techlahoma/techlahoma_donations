class HomeController < ApplicationController
  def index
  end

  def sponsorship
    @plan_bases = Plan.sponsor_bases
  end
end
