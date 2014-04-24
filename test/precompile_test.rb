require 'test_helper'

class PrecompileTest < TestCase
  def setup
    delete_assets!
  end

  def teardown
    ENV['RAILS_ENV'] = 'test'
    delete_assets!
  end

  def delete_assets!
    FileUtils.rm_rf app_path.join('public', 'assets')
    FileUtils.rm_rf app_path.join('tmp', 'cache','assets')
  end

  def precompile!(rails_env)
    # ENV['RAILS_ENV'] = rails_env

    # quietly do
      Dir.chdir(app_path) { `RAILS_ENV=#{rails_env} bundle exec rake assets:precompile` }
    # end

    appjs = Dir["#{app_path}/public/assets/application*.js"].first

    assert appjs, "the file #{app_path}/public/assets/application.js should exist"
    contents = File.read(appjs)

    assert_match 'angular.module("templates", []);', contents
    assert_match 'angular.module("templates")', contents
    assert_match /\.put\("template\.html",/, contents
    assert_match /\.put\("subfolder\/template\.html",/, contents
    assert_match /\.put\("hello-world\.html",/, contents
    assert_match /\.put\("erb_template\.html",/, contents
    assert_match /\.put\("slim_template\.html",/, contents
    assert_match /\.put\("haml_template\.html",/, contents
    assert_match /\.put\("subfolder\/slim_template\.html",/, contents
    assert_match /\.put\("subfolder\/haml_template\.html",/, contents
    assert_match "ajs-haml", contents

    # Check that we render slim templates
    unescaped = contents.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
    assert_match /<h1>I am ast template<\/h1>/, unescaped

    assert_not_match '.put("ignored_namespace/', contents

    assert_match "Ignore Prefix: ignored_namespace/", contents
    assert_match /source: .+\/ignored_namespace\//, contents
  end

  def app_path
    Pathname.new("#{File.dirname(__FILE__)}/dummy")
  end

  def test_precompile_succeeds_in_development_environment
    precompile! 'development'
  end

  # def test_precompile_succeeds_in_production_environment
  #   precompile! 'production'
  # end

  # def test_precompile_succeeds_in_test_environment
  #   precompile! 'test'
  # end
end
