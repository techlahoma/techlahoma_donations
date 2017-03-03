require 'rails_helper'

RSpec.describe Admin::SubscriptionsController, type: :controller do

  before :each do
    StripeMock.start
    SubscriptionPlan.create_stripe_plan(42)
    @plan_id = SubscriptionPlan.plan_stripe_id(42)
    @user = create :user
    login_user(@user)
  end

  after :each do
    StripeMock.stop
  end
  
  # This should return the minimal set of attributes required to create a valid
  # Subscription. As you add validations to Subscription, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    :name => "test person",
    :email => "test@person.com",
    :stripe_plan_id => @plan_id,
    :token_id => StripeMock.generate_card_token(last4: "9191", exp_year: 1984)
  }}

  let(:invalid_attributes) {{
    :name => "test person",
    :email => nil,
    :stripe_plan_id => @plan_id,
    :token_id => StripeMock.generate_card_token(last4: "9191", exp_year: 1984)
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SubscriptionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all subscriptions as @subscriptions" do
      subscription = Subscription.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:subscriptions)).to eq([subscription])
    end
  end

  describe "GET #show" do
    it "assigns the requested subscription as @subscription" do
      subscription = Subscription.create! valid_attributes
      get :show, {:id => subscription.to_param}, valid_session
      expect(assigns(:subscription)).to eq(subscription)
    end
  end

  #describe "GET #new" do
    #it "assigns a new subscription as @subscription" do
      #get :new, {}, valid_session
      #expect(assigns(:subscription)).to be_a_new(Subscription)
    #end
  #end

  #describe "GET #edit" do
    #it "assigns the requested subscription as @subscription" do
      #subscription = Subscription.create! valid_attributes
      #get :edit, {:id => subscription.to_param}, valid_session
      #expect(assigns(:subscription)).to eq(subscription)
    #end
  #end

  #describe "POST #create" do
    #context "with valid params" do
      #it "creates a new Subscription" do
        #expect {
          #post :create, {:subscription => valid_attributes}, valid_session
        #}.to change(Subscription, :count).by(1)
      #end

      #it "assigns a newly created subscription as @subscription" do
        #post :create, {:subscription => valid_attributes}, valid_session
        #expect(assigns(:subscription)).to be_a(SubscriptionCreator)
        #expect(assigns(:subscription)).to be_persisted
      #end

      #it "redirects to the created subscription" do
        #post :create, {:subscription => valid_attributes}, valid_session
        #expect(response).to redirect_to(Subscription.last)
      #end
    #end

    #context "with invalid params" do
      #it "assigns a newly created but unsaved subscription as @subscription" do
        #post :create, {:subscription => invalid_attributes}, valid_session
        #expect(assigns(:subscription)).to be_a_new(SubscriptionCreator)
      #end

      #it "re-renders the 'new' template" do
        #post :create, {:subscription => invalid_attributes}, valid_session
        #expect(response).to render_template("new")
      #end
    #end
  #end

  #describe "PUT #update" do
    #context "with valid params" do
      #let(:new_attributes) {
        #skip("Add a hash of attributes valid for your model")
      #}

      #it "updates the requested subscription" do
        #subscription = Subscription.create! valid_attributes
        #put :update, {:id => subscription.to_param, :subscription => new_attributes}, valid_session
        #subscription.reload
        #skip("Add assertions for updated state")
      #end

      #it "assigns the requested subscription as @subscription" do
        #subscription = Subscription.create! valid_attributes
        #put :update, {:id => subscription.to_param, :subscription => valid_attributes}, valid_session
        #expect(assigns(:subscription)).to eq(subscription)
      #end

      #it "redirects to the subscription" do
        #subscription = Subscription.create! valid_attributes
        #put :update, {:id => subscription.to_param, :subscription => valid_attributes}, valid_session
        #expect(response).to redirect_to(subscription)
      #end
    #end

    #context "with invalid params" do
      #it "assigns the subscription as @subscription" do
        #subscription = Subscription.create! valid_attributes
        #put :update, {:id => subscription.to_param, :subscription => invalid_attributes}, valid_session
        #expect(assigns(:subscription)).to eq(subscription)
      #end

      #it "re-renders the 'edit' template" do
        #subscription = Subscription.create! valid_attributes
        #put :update, {:id => subscription.to_param, :subscription => invalid_attributes}, valid_session
        #expect(response).to render_template("edit")
      #end
    #end
  #end

  describe "DELETE #destroy" do
    it "cancels the requested subscription" do
      subscription = Subscription.create! valid_attributes
      expect_any_instance_of(Subscription).to receive(:cancel).and_return(nil)
      expect {
        delete :destroy, {:id => subscription.to_param}, valid_session
      }.to change(Subscription, :count).by(0)
    end

    it "redirects to the subscription" do
      subscription = Subscription.create! valid_attributes
      expect_any_instance_of(Subscription).to receive(:cancel).and_return(nil)
      delete :destroy, {:id => subscription.to_param}, valid_session
      expect(response).to redirect_to(subscription)
    end
  end

end
