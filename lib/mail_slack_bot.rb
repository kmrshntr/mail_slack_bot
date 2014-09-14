require 'mail_slack_bot/version'
require 'configatron/core'
require 'mail'
require 'slack-notifier'

module MailSlackBot

  class Config

    include Singleton

    class << self

      attr_accessor :configuration

      def load_config(config_path)
        load config_path
      end

      def configure
        @configuration = Configatron::RootStore.new
        @configuration.mail = Mail::Configuration.instance
        yield(@configuration)
      end

    end

  end

  class Daemon

    def initialize(opts)
      MailSlackBot::Config.load_config opts[:config_path]
      @config = MailSlackBot::Config.configuration
    end

    def run
      loop do
        mails = Mail.all
        notifier = Slack::Notifier.new(@config.slack.team, @config.slack.token,
                    channel: @config.slack.channel, username: @config.slack.username)
        mails.each do |mail|
          notifier.ping mail.body.decoded, pretext: mail.subject
        end
        sleep @config.mail_check_interval
      end
    end

  end
end
