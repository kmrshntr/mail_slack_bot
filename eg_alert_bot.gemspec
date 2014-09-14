# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eg_alert_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "eg_alert_bot"
  spec.version       = EgAlertBot::VERSION
  spec.authors       = ["Kimura"]
  spec.email         = ["kimura@enigmo.co.jp"]
  spec.summary       = %q{This is a slack bot saying service alert.}
  spec.description   = %q{This is a slack bot saying service alert.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
