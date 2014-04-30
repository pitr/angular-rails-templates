# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

# Remove tmp dir of dummy app before it's booted.
FileUtils.rm_rf "#{File.dirname(__FILE__)}/dummy/tmp"

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'minitest/autorun'
require 'capybara/rails'
require 'active_support/core_ext/kernel/reporting'

Rails.backtrace_cleaner.remove_silencers!

# Support MiniTest 4/5
Minitest::Test = MiniTest::Unit::TestCase unless defined? Minitest::Test

class IntegrationTest < MiniTest::Spec
  include Capybara::DSL
  register_spec_type(/integration$/, self)
end
