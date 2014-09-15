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

To create a bot, write a class that extends MailSlackBot::Daemon and provides mail and slack settings For example:

```ruby
require 'mail_slack_bot'

class BmAlertBot < MailSlackBot

  configure do |config|
    config.slack.team = ENV["SLACK_TEAM"]
    config.slack.token = ENV["SLACK_TOKEN"]
    config.slack.channel = '#alert'
    config.slack.username = 'alert'
  
    config.mail_check_interval = 10 # seconds
  
    config.mail.retriever_method :pop3,
                            :address    => "pop.gmail.com",
                            :port       => 995,
                            :user_name  => ENV["MAIL_USERNAME"],
                            :password   => ENV["MAIL_PASSWORD"],
                            :enable_ssl => true
  end

end

BmAlertBot.new.run

```

## Contributing

1. Fork it ( https://github.com/kmrshntr/mail_slack_bot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
