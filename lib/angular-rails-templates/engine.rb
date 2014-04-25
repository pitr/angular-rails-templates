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
          # Processed haml/slim templates have a mime-type of text/html.
          # If sprockets sees a `foo.html.haml` it will process the haml
          # and stop, because the haml output is html. Our html engine won't get run.
          mimeless_engine = Class.new(Tilt[ext]) do
            def self.default_mime_type
              nil
            end
          end

          Sprockets.register_engine ".#{ext}", mimeless_engine
        end

        # This engine wraps the HTML into JS
        Sprockets.register_engine '.html', AngularRailsTemplates::Template
      end
    end
  end
end
