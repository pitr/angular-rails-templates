require 'angular-rails-templates/engine'

module AngularRailsTemplates
  autoload :Template, 'angular-rails-templates/template'
  autoload :VERSION,  'angular-rails-templates/version'

  class << self
    attr_accessor :extension
  end
end

AngularRailsTemplates.extension = '.html'

