module AngularRailsTemplates
  class Engine < ::Rails::Engine
    config.angular_templates = ActiveSupport::OrderedOptions.new
    config.angular_templates.module_name    = 'templates'
    config.angular_templates.ignore_prefix  = ['templates/']
    config.angular_templates.inside_paths   = ['app/assets']
    config.angular_templates.markups        = []
    config.angular_templates.extension      = 'html'

    config.before_configuration do |app|
      # try loading common markups
      %w(erb haml liquid md radius slim str textile wiki).
      each do |ext|
        begin
          silence_warnings do
            config.angular_templates.markups << ext if Tilt[ext]
          end
        rescue LoadError
          # They don't have the required library required. Oh well.
        end
      end
    end


    initializer 'angular-rails-templates', group: :all  do |app|
      if defined?(Sprockets::Railtie)
        config.assets.configure do |env|
          env.register_mime_type 'text/ng-html', extensions: [".#{app.config.angular_templates.extension}"]
          env.register_transformer 'text/ng-html', 'application/javascript', AngularRailsTemplates::Processor

          # These engines render markup as HTML
          app.config.angular_templates.markups.each do |ext|
            if ::Sprockets::VERSION.to_i < 4
              env.register_engine ".#{ext}", Tilt[ext]
            else
              AngularRailsTemplates::Processor::Tilt.install(env, ext,
                                                             app.config.angular_templates.extension)
            end
          end
        end
      end

      # Sprockets Cache Busting
      # If ART's version or settings change, expire and recompile all assets
      app.config.assets.version = [
        app.config.assets.version,
        'ART',
        Digest::MD5.hexdigest("#{VERSION}-#{app.config.angular_templates}")
      ].join '-'
    end


    config.after_initialize do |app|
      # Ensure ignore_prefix can be passed as a String or Array
      if app.config.angular_templates.ignore_prefix.is_a? String
        app.config.angular_templates.ignore_prefix = Array(app.config.angular_templates.ignore_prefix)
      end
    end
  end
end
