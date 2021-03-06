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

RSpec.describe Admin::DonationRollUpsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # DonationRollUp. As you add validations to DonationRollUp, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DonationRollUpsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all donation_roll_ups as @donation_roll_ups" do
      donation_roll_up = DonationRollUp.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:donation_roll_ups)).to eq([donation_roll_up])
    end
  end

  describe "GET #show" do
    it "assigns the requested donation_roll_up as @donation_roll_up" do
      donation_roll_up = DonationRollUp.create! valid_attributes
      get :show, params: {id: donation_roll_up.to_param}, session: valid_session
      expect(assigns(:donation_roll_up)).to eq(donation_roll_up)
    end
  end

end
