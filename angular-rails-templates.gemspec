# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "angular-rails-templates/version"

Gem::Specification.new do |s|
  s.name        = "angular-rails-templates"
  s.version     = AngularRailsTemplates::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Damien Mathieu", 'pitr']
  s.email       = ["42@dmathieu.com"]
  s.homepage    = "https://github.com/pitr/angular-rails-templates"
  s.summary     = "Use your angular templates with rails' asset pipeline"

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "app/**/*"]
  s.license = 'MIT'

  s.require_paths = ["lib"]

  s.add_dependency "railties", ">= 3.1"
  s.add_dependency "sprockets"

  s.add_development_dependency "minitest", "~> 5.3.3"
  s.add_development_dependency "capybara", "~> 2.2.1"
end
