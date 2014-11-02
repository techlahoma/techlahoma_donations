require 'slack-notifier'

class Chat

  def self.slack_message(message)
      notifier = regularteam
      notifier.ping Slack::Notifier::LinkFormatter.format(message)
  end

    private
    def self.regularteam
      Slack::Notifier.new ENV["SLACK_URL"],
                                  channel: '#techlahoma', username: 'Donations'
    end
end


##<Net::HTTPOK 200 OK readbody=true>
