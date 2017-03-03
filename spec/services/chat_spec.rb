require 'rails_helper'

RSpec.describe Chat, type: :service do
  describe "slack_message" do
    it "delegates to Slack::Notifier" do
      ENV["SLACK_URL"] = "http://test.com/"
      expect_any_instance_of(Slack::Notifier).to receive(:ping).and_return(nil)
      Chat.slack_message("just a test")
    end
  end
end
