# MailSlackBot

This is a slack bot which receives and posts emails to slack.

## Installation

Add this line to your application's Gemfile:

    gem 'mail_slack_bot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mail_slack_bot

## Usage

To create a bot, write a class that extends MailSlackBot and provides mail and slack settings For example:

```ruby
require 'mail_slack_bot'

class MyAlertBot < MailSlackBot

  configure do |config|
    config.slack.team = ENV["SLACK_TEAM"]
    config.slack.token = ENV["SLACK_TOKEN"]
    config.logger = Logger.new('log/my_alert_bot.log') # The default is STDOUT.
    config.slack.channel = '#alert' # The default is '#general'
    config.slack.username = 'alert' # The default is 'mail'
    config.slack.icon_emoji = ':rage:' # The default is ':mail:'

    # See also https://github.com/mikel/mail#getting-emails-from-a-pop-server
    config.mail.retriever_method :pop3,
                            :address    => "pop.gmail.com",
                            :port       => 995,
                            :user_name  => ENV["MAIL_USERNAME"],
                            :password   => ENV["MAIL_PASSWORD"],
                            :enable_ssl => true
  end

end

MyAlertBot.new.run

```

## Contributing

1. Fork it ( https://github.com/kmrshntr/mail_slack_bot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
