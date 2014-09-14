require 'mail_slack_bot/version'
require 'configatron/core'
require 'mail'
require 'slack-notifier'
require 'daemon_spawn'
require 'logger'

module MailSlackBot

  class Daemon < DaemonSpawn::Base

    $logger = Logger.new(STDOUT)

    class << self

      def configure
        @configuration = Configatron::RootStore.new
        @configuration.mail = Mail::Configuration.instance
        yield(@configuration)
      end

      def config
        @configuration
      end

    end

    def start(args)
      @config = self.class.config
      sleep_time = @config.mail_check_interval || 10
      slack_client = Slack::Notifier.new(@config.slack.team, @config.slack.token,
                                         channel: @config.slack.channel, username: @config.slack.username)
      loop do
        $logger.debug("Feching mail.")
        Mail.all.each do |mail|
          $logger.debug mail.subject
          $logger.debug mail.body.decoded
          manipulate(mail, slack_client)
        end
        sleep sleep_time
      end
    end

    def manipulate(mail, slack_client)
      slack_client.ping mail.body.decoded.encode("UTF-8", undef: :replace, invalid: :replace),
                        pretext: mail.subject
    end
  
    def stop
    end

  end
end
