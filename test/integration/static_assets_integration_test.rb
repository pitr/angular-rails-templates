require 'test_helper'

# Test the Assets the Gem Provides

describe "static assets integration" do
  let(:config) { Dummy::Application.config.angular_templates }

  it "serves angular-rails-templates.js on the pipeline" do
    visit '/assets/angular-rails-templates.js'
    page.text.must_include %Q{angular.module("#{config.module_name}", [])}
  end
end
