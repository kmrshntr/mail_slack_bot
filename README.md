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

```ruby:my_alert_bot.rb

require 'mail_slack_bot'

class MyAlertBot < MailSlackBot::Daemon

  configure do |config|

    # Slack settings
    config.slack.team = ENV["SLACK_TEAM"]
    config.slack.token = ENV["SLACK_TOKEN"]
    config.slack.channel = '#alert'
    config.slack.username = 'alert'
  
    # Mail checking interval
    config.mail_check_interval = 10 # seconds
  
    # Uses https://github.com/mikel/mail,
    # so it's same as Mail.defaults https://github.com/mikel/mail#getting-emails-from-a-pop-server 
    config.mail.retriever_method :pop3,
                            :address    => "pop.gmail.com",
                            :port       => 995,
                            :user_name  => ENV["MAIL_USERNAME"],
                            :password   => ENV["MAIL_PASSWORD"],
                            :enable_ssl => true
  end

end

# See also https://github.com/alexvollmer/daemon-spawn
MyAlertBot.spawn!(log_file: 'my_alert_bot.log',
                  pid_file: 'my_alert_bot.pid',
                  sync_log: true,
                  working_dir: File.dirname(__FILE__))

```

And run above script like following:

```
ruby my_alert_bot.rb start
```

## Contributing

1. Fork it ( https://github.com/kmrshntr/mail_slack_bot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
