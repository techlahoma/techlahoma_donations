class Admin::DonationRollUpsController < Admin::AdminController
  before_action :set_donation_roll_up, only: [:show, :edit, :update, :destroy]

  # GET /donation_roll_ups
  # GET /donation_roll_ups.json
  def index
    @donation_roll_ups = DonationRollUp.all
  end

  # GET /donation_roll_ups/1
  # GET /donation_roll_ups/1.json
  def show
  end

  # GET /donation_roll_ups/new
  def new
    @donation_roll_up = DonationRollUp.new
  end

  # GET /donation_roll_ups/1/edit
  def edit
  end

  # POST /donation_roll_ups
  # POST /donation_roll_ups.json
  def create
    @donation_roll_up = DonationRollUp.new(donation_roll_up_params)

    respond_to do |format|
      if @donation_roll_up.save
        format.html { redirect_to @donation_roll_up, notice: 'Donation roll up was successfully created.' }
        format.json { render :show, status: :created, location: @donation_roll_up }
      else
        format.html { render :new }
        format.json { render json: @donation_roll_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donation_roll_ups/1
  # PATCH/PUT /donation_roll_ups/1.json
  def update
    respond_to do |format|
      if @donation_roll_up.update(donation_roll_up_params)
        format.html { redirect_to @donation_roll_up, notice: 'Donation roll up was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation_roll_up }
      else
        format.html { render :edit }
        format.json { render json: @donation_roll_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donation_roll_ups/1
  # DELETE /donation_roll_ups/1.json
  def destroy
    @donation_roll_up.destroy
    respond_to do |format|
      format.html { redirect_to donation_roll_ups_url, notice: 'Donation roll up was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation_roll_up
      @donation_roll_up = DonationRollUp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_roll_up_params
      params.require(:donation_roll_up).permit(:email, :amount, :start_time, :end_time)
    end
end
