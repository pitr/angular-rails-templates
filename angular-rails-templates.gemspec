# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "angular-rails-templates/version"

Gem::Specification.new do |s|
  s.name        = "angular-rails-templates"
  s.version     = AngularRailsTemplates::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Damien Mathieu"]
  s.email       = ["42@dmathieu.com"]
  s.homepage    = "https://github.com/dmathieu/angular-rails-templates"
  s.summary     = "Use your angular templates with rails' asset pipeline"

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "app/**/*"]

  s.require_paths = ["lib"]

  s.add_dependency "railties",  [">= 3.1"]
  s.add_dependency "sprockets-rails"

  s.add_development_dependency "uglifier"
end
