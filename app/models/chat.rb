require 'slack-notifier'

class Chat

  def self.slack_message(message)
      notifier = regularteam
      notifier.ping Slack::Notifier::LinkFormatter.format(message)
  end
  
    private
    def self.regularteam
      Slack::Notifier.new "nerdbeers", ENV["SLACK_API"],
                                  channel: '#techlahoma', username: 'Donations'
    end
end


##<Net::HTTPOK 200 OK readbody=true>