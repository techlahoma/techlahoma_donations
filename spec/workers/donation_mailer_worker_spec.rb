require 'rails_helper'
RSpec.describe DonationMailerWorker, type: :worker do
  before :each do
    ActionMailer::Base.deliveries.clear
    Sidekiq::Testing.inline!
  end
  let(:worker){ DonationMailerWorker.new }
  describe "perform" do
    it "should call the mailer" do
      donation = create :donation
      worker.perform(donation.id)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
