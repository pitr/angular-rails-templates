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

    # render .html
    assert_match /\.put\("plain\.html",/, contents

    # render .html.slim
    assert_match /\.put\("slim_template\.html",/, contents
    assert_match /<h1>slim template<\/h1>/, contents

    # render .html.haml
    assert_match /\.put\("haml_template\.html",/, contents

    # subfolders
    assert_match /\.put\("subfolder\/slim_template\.html",/, contents
    assert_match /\.put\("subfolder\/haml_template\.html",/, contents
    assert_match /\.put\("subfolder\/template\.html",/, contents
    assert_match /\.put\("subfolder2\/template\.html",/, contents

    # render .html.erb with ruby expression
    assert_match /\.put\("erb_template\.html",/, contents

    # render .html.md
    assert_match '.put("markdown.html",', contents
    assert_match "<h3>Markdown!</h3>", contents

    # ignore_prefix
    assert_match /\.put\("hello-world\.html",/, contents
    refute_match '.put("ignored_namespace/', contents

    # templates in app/assets/templates
    assert_match "outside-javascript", contents
    assert_match '.put("test.html",', contents
    assert_match '.put("sub/sub.html",', contents

    contents
  end

  def app_path
    Pathname.new("#{File.dirname(__FILE__)}/dummy")
  end

  def test_precompile_succeeds_in_development_environment
    contents = precompile! 'development'

    assert_match "angular_templates.ignore_prefix: ignored_namespace/", contents
    assert_match "angular_templates.markups:", contents
    assert_match /source: .+\/ignored_namespace\//, contents
  end

  def test_precompile_succeeds_in_production_environment
    precompile! 'production'
  end

end
