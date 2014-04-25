require 'test_helper'

# Test the Asset the Gem Provides

describe "angular-rails-templates.js integration" do
  let(:config) { Dummy::Application.config.angular_templates }

  it "serves angular-rails-templates.js on the pipeline" do
    visit '/assets/angular-rails-templates.js'
    page.source.must_include %Q{angular.module("#{config.module_name}", [])}
  end

  it "includes a comment with the gem name and version" do
    visit '/assets/angular-rails-templates.js'
    page.source.must_include %Q{// Angular Rails Templates #{AngularRailsTemplates::VERSION}}
  end

  it "includes a comment describing the ignore_prefix" do
    visit '/assets/angular-rails-templates.js'
    page.source.must_include %Q{// angular_templates.ignore_prefix: #{config.ignore_prefix}}
  end

  it "includes a comment describing the availible markups" do
    visit '/assets/angular-rails-templates.js'
    page.source.must_include %Q{// angular_templates.markups: #{config.markups}}
  end
end
