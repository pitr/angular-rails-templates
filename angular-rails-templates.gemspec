# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "angular-rails-templates/version"

Gem::Specification.new do |s|
  s.name        = "angular-rails-templates"
  s.version     = AngularRailsTemplates::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Damien Mathieu", 'pitr', 'whitehat101']
  s.email       = ["pitr.vern@gmail.com"]
  s.homepage    = "https://github.com/pitr/angular-rails-templates"
  s.summary     = "Use your angular templates with rails' asset pipeline"

  s.files = %w(README.md LICENSE) + Dir["lib/**/*", "vendor/**/*"]
  s.license = 'MIT'

  s.require_paths = ["lib"]

  s.add_dependency "railties", ">= 4.2", "< 6"
  s.add_dependency "sprockets", ">= 3.0", '< 5'
  s.add_dependency "tilt"

  s.add_development_dependency "minitest"
  s.add_development_dependency "capybara"
  s.add_development_dependency "uglifier"
end
