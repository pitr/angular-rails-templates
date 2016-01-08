require 'test_helper'

require 'fileutils'
require 'pathname'

class PrecompileTest < Minitest::Test
  def setup
    delete_assets!
  end

  def teardown
    delete_assets!
  end

  def delete_assets!
    FileUtils.rm_rf app_path.join('public', 'assets')
    FileUtils.rm_rf app_path.join('tmp', 'cache','assets')
  end

  def precompile!(rails_env)
    quietly do
      Dir.chdir(app_path) { `bundle exec rake assets:precompile RAILS_ENV=#{rails_env}` }
    end

    appjs = Dir["#{app_path}/public/assets/application*.js"].first

    assert appjs, "the file #{app_path}/public/assets/application.js should exist"
    contents = File.read(appjs)

    # essential javascript things
    assert_match /angular\.module\("templates", ?\[\]\)[,;]/, contents
    assert_match 'angular.module("templates")', contents

    # Test the inclusion of the templates
    %w(haml_template plain sub/sub sub/sub2 subfolder/haml_template subfolder/template subfolder2/template test).
    each do |file|
      assert_match %Q{.put("#{file}.html"}, contents
    end

    # no templates starting with the ignored namespace are in the bundle
    refute_match '.put("ignored_namespace/', contents

    contents
  end

  def app_path
    Pathname.new("#{File.dirname(__FILE__)}/dummy")
  end

  def test_precompile_succeeds_in_development_environment
    contents = precompile! 'development'

    assert_match "angular_templates.ignore_prefix: [\"ignored_namespace/\"]", contents
    assert_match "angular_templates.markups:", contents
    assert_match /source: .+\/ignored_namespace\//, contents
  end

  def test_precompile_succeeds_in_production_environment
    precompile! 'production'
  end

end
