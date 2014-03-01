module AngularRailsTemplates
  class Engine < ::Rails::Engine
    config.angular_templates = ActiveSupport::OrderedOptions.new
    config.angular_templates.module_name = 'templates'
    config.angular_templates.ignore_prefix = 'templates/'

    config.before_initialize do |app|
      if app.config.assets
        require 'sprockets'
        Sprockets::Engines #force autoloading

        Sprockets.register_engine '.ast',  AngularRailsTemplates::SlimTemplate
        Sprockets.register_engine '.aht',  AngularRailsTemplates::HamlTemplate
        Sprockets.register_engine '.ajs',  AngularRailsTemplates::GenericTemplate
        Sprockets.register_engine '.html', AngularRailsTemplates::GenericTemplate
      end
    end
  end
end
