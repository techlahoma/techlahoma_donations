class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @plan = params[:plan_id] ? Plan.find_by_stripe_id(params[:plan_id]) : Plan.plan_list.first
    @subscription = Subscription.new({
      :amount => (@plan[:cost_in_dollars] * 100).to_i,
      :stripe_plan_id => @plan[:id]
    })
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  rescue Stripe::CardError => e
    @plan = Plan.find(params[:subscription][:plan_id])
    @subscription.errors.add("Credit card", e)
    respond_to do |format|
      format.html { render :new, flash: { error: e.to_s } }
      format.json { render json: @subscription.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.cancel
    respond_to do |format|
      format.html { redirect_to @subscription, notice: 'Subscription was successfully canceled.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find_by_guid(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:email, :stripe_plan_id, :token_id, :name)
    end
end
