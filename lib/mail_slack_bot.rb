require 'mail_slack_bot/version'
require 'configatron/core'
require 'mail'
require 'slack-notifier'
require 'daemon_spawn'

module MailSlackBot

  class Daemon < DaemonSpawn::Base

    class << self

      attr_accessor :team, :token, :channel, :username

      def configure_mail(&block)
        Mail::Configuration.instance.instance_eval(&block)
      end

      def configure_slack(&block)
        instance_eval(&block)
      end

    end

    def start(args)
      slack_client = Slack::Notifier.new(self.class.team, 
        self.class.token, channel: self.class.channel, username: self.class.username)      
      loop do
        Mail.all.each do |mail|
          manipulate(mail, slack_client)
        end
      end
    end

    def manipulate(mail, slack_client)
      slack_client.ping mail.body.decoded, pretext: mail.subject
    end
  
    def stop
    end

  end
end
