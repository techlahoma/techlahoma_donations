class CouponsController < ApplicationController
  def show
    @donation_roll_up = DonationRollUp.find_by(guid: params[:id])
  end

  #def destroy
    #@donation_roll_up = DonationRollUp.find_by(guid: params[:id])
    #EcwidDiscountCouponDestroyer.call(@donation_roll_up)
    #redirect_to coupon_path(@donation_roll_up)
  #end
end
