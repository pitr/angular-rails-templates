module AngularRailsTemplates
  class Engine < ::Rails::Engine
    config.angular_templates = ActiveSupport::OrderedOptions.new
    config.angular_templates.module_name   = 'templates'
    config.angular_templates.ignore_prefix = 'templates/'
    config.angular_templates.markups       = []

    # try loading common markups
    %w(erb str haml slim md nokogiri wiki).each do |ext|
      begin
        config.angular_templates.markups << ext if Tilt[ext]
      rescue LoadError
        # They don't have the required libray required. Oh well.
      end
    end


    config.before_initialize do |app|
      if app.config.assets
        require 'sprockets'
        Sprockets::Engines #force autoloading

        # These engines render markup as HTML
        config.angular_templates.markups.each do |ext|
          Sprockets.register_engine ".#{ext}", Tilt[ext]
          # puts ".#{ext} #{Tilt[ext]}"
        end

        # This engine wraps the HTML into JS
        Sprockets.register_engine '.html', AngularRailsTemplates::Template
      end
    end
  end
end
