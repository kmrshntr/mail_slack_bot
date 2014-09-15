# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_slack_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "mail_slack_bot"
  spec.version       = MailSlackBot::VERSION
  spec.authors       = ["Shintaro Kimura"]
  spec.email         = ["kmrshntr@gmail.com"]
  spec.summary       = %q{Receives and posts emails to slack.}
  spec.description   = %q{This is a slack bot which receives and posts emails to slack.}
  spec.homepage      = "https://github.com/kmrshntr/mail_slack_bot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_runtime_dependency "mail", "~> 2.6"
  spec.add_runtime_dependency "daemon-spawn", "~> 0.4"
  spec.add_runtime_dependency "slack-notifier", "~> 0.6"
  spec.add_runtime_dependency "configatron", "~> 4.2"

end
