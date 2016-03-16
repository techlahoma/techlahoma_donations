class HomeController < ApplicationController
  def index
    @goal = 60_000
    @raised = Donation.in_campaign.sum(:amount)
  end

  def sponsorship
    @plan_bases = Plan.sponsor_bases
  end

  def giftpolicy
  end
end
