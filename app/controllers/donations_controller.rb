class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all.order("created_at asc")
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
  end

  # GET /donations/new
  def new
    @plan = Plan.find(params[:plan_id])
    amount = @plan ? (@plan[:cost_in_dollars_per_year] * 100).to_i : 50
    @donation = Donation.new({
      :amount => amount,
      :plan_id => params[:plan_id]
    })
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(donation_params)

    respond_to do |format|
      if @donation.save
        format.html { redirect_to @donation, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        @plan = Plan.find(params[:donation][:plan_id])
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  rescue Stripe::CardError => e
    @plan = Plan.find(params[:donation][:plan_id])
    @donation.errors.add("Credit card", e)
    respond_to do |format|
      format.html { render :new, flash: { error: e.to_s } }
      format.json { render json: @donation.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_plan

    end
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find_by_guid!(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:email, :amount, :name, :token_id, :plan_id,
                                      :address1, :address2, :city, :state, :zipcode, :accept_gift,
                                      :tee_shirt_size, :tee_shirt_color,
                                      :polo_size, :polo_color,
                                      :hoodie_size, :hoodie_color, :gift_selected, :accept_recognition,
                                      :notes
                                      )
    end
end
