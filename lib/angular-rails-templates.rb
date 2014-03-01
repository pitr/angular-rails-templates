module AngularRailsTemplates
  autoload :Template        , 'angular-rails-templates/template'
  autoload :GenericTemplate , 'angular-rails-templates/generic_template'
  autoload :SlimTemplate    , 'angular-rails-templates/slim_template'
  autoload :HamlTemplate    , 'angular-rails-templates/haml_template'
  autoload :Version         , 'angular-rails-templates/version'
end

require 'angular-rails-templates/engine'
