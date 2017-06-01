require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe DonationsController, type: :controller do

  before :each do
    StripeMock.start
  end

  after :each do
    StripeMock.stop
  end
  # This should return the minimal set of attributes required to create a valid
  # Donation. As you add validations to Donation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    :name => "test person",
    :email => "test@person.com",
    :amount => 1000,
    :token_id => StripeMock.generate_card_token(last4: "9191", exp_year: 1984)
  }}

  let(:invalid_attributes) {{
    :name => "test person",
    :email => nil,
    :amount => 0,
    :token_id => StripeMock.generate_card_token(last4: "9191", exp_year: 1984)
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DonationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all donations as @donations" do
      donation = Donation.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:donations).length).to eq([donation].length)
    end
  end

  describe "GET #show" do
    it "assigns the requested donation as @donation" do
      donation = Donation.create! valid_attributes
      get :show, {:id => donation.to_param}, valid_session
      expect(assigns(:donation)).to eq(donation)
    end
  end

  describe "GET #new" do
    it "assigns a new donation as @donation" do
      get :new, {}, valid_session
      expect(assigns(:donation)).to be_a_new(Donation)
    end
  end

  #describe "GET #edit" do
    #it "assigns the requested donation as @donation" do
      #donation = Donation.create! valid_attributes
      #get :edit, {:id => donation.to_param}, valid_session
      #expect(assigns(:donation)).to eq(donation)
    #end
  #end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Donation" do
        expect {
          post :create, {:donation => valid_attributes}, valid_session
        }.to change(Donation, :count).by(1)
      end

      it "assigns a newly created donation as @donation" do
        post :create, {:donation => valid_attributes}, valid_session
        expect(assigns(:donation)).to be_a(DonationCreator)
        expect(assigns(:donation)).to be_persisted
      end

      it "redirects to the created donation" do
        post :create, {:donation => valid_attributes}, valid_session
        expect(response).to redirect_to(Donation.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved donation as @donation" do
        post :create, {:donation => invalid_attributes}, valid_session
        expect(assigns(:donation)).to be_a_new(DonationCreator)
      end

      it "re-renders the 'new' template" do
        post :create, {:donation => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  #describe "PUT #update" do
    #context "with valid params" do
      #let(:new_attributes) {
        #skip("Add a hash of attributes valid for your model")
      #}

      #it "updates the requested donation" do
        #donation = Donation.create! valid_attributes
        #put :update, {:id => donation.to_param, :donation => new_attributes}, valid_session
        #donation.reload
        #skip("Add assertions for updated state")
      #end

      #it "assigns the requested donation as @donation" do
        #donation = Donation.create! valid_attributes
        #put :update, {:id => donation.to_param, :donation => valid_attributes}, valid_session
        #expect(assigns(:donation)).to eq(donation)
      #end

      #it "redirects to the donation" do
        #donation = Donation.create! valid_attributes
        #put :update, {:id => donation.to_param, :donation => valid_attributes}, valid_session
        #expect(response).to redirect_to(donation)
      #end
    #end

    #context "with invalid params" do
      #it "assigns the donation as @donation" do
        #donation = Donation.create! valid_attributes
        #put :update, {:id => donation.to_param, :donation => invalid_attributes}, valid_session
        #expect(assigns(:donation)).to eq(donation)
      #end

      #it "re-renders the 'edit' template" do
        #donation = Donation.create! valid_attributes
        #put :update, {:id => donation.to_param, :donation => invalid_attributes}, valid_session
        #expect(response).to render_template("edit")
      #end
    #end
  #end

  #describe "DELETE #destroy" do
    #it "destroys the requested donation" do
      #donation = Donation.create! valid_attributes
      #expect {
        #delete :destroy, {:id => donation.to_param}, valid_session
      #}.to change(Donation, :count).by(-1)
    #end

    #it "redirects to the donations list" do
      #donation = Donation.create! valid_attributes
      #delete :destroy, {:id => donation.to_param}, valid_session
      #expect(response).to redirect_to(donations_url)
    #end
  #end

end
