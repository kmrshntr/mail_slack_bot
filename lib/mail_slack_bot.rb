require 'mail_slack_bot/version'
require 'configatron/core'
require 'mail'
require 'slack-notifier'
require 'daemon_spawn'
require 'logger'
require 'nkf'

class MailSlackBot

  class << self

    attr_reader :config

    def configure
      @config = Configatron::RootStore.new
      @config.slack.channel = '#general'
      @config.slack.username = 'mail'
      @config.slack.icon_emoji = ':mail:'
      @config.mail_check_interval = 10
      @config.mail = Mail::Configuration.instance
      @config.logger = Logger.new(STDOUT)
      yield(@config)
    end

  end

  def run
    @config = self.class.config
    yield(@config) if block_given?
    @logger = @config.logger
    sleep_time = @config.mail_check_interval
    slack_client = Slack::Notifier.new(@config.slack.team, @config.slack.token,
                                       channel: @config.slack.channel, username: @config.slack.username)
    loop do
      begin
        @logger.debug("Feching mail.")
        Mail.all.each do |mail|
          @logger.debug mail.subject
          @logger.debug mail.body.decoded
          manipulate(mail, slack_client)
        end
      rescue => e
        slack_client.ping e.backtrace.join("\n"), pretext: e.message, icon_emoji: ":bow:"
      end
      sleep sleep_time
    end
  end

  def manipulate(mail, slack_client)
    text_plain = if mail.multipart?
      mail.parts.detect { |p| p.content_type =~ /text\/plain/i }.body.decoded
    else
      mail.body.decoded
    end
    slack_client.ping NKF.nkf('-w', text_plain),
                             pretext: mail.subject,
                             icon_emoji: @config.slack.icon_emoji
  end

end
