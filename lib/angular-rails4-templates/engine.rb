require 'tilt'

module AngularRails4Templates
  class Engine < ::Rails::Engine
    config.angular_templates = ActiveSupport::OrderedOptions.new
    config.angular_templates.module_name    = 'templates'
    config.angular_templates.ignore_prefix  = ['templates/']
    config.angular_templates.inside_paths   = [] # defined in before_configuration
    config.angular_templates.markups        = []
    config.angular_templates.htmlcompressor = false

    config.before_configuration do |app|
      config.angular_templates.inside_paths = [Rails.root.join('app', 'assets')]

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
      app.config.assets.configure do |env|
        require 'sprockets'
        require 'sprockets/engines' # load sprockets for Rails 3

        env.register_mime_type 'text/ng-html', extensions: ['.nghtml']
        env.register_mime_type 'text/ng-haml', extensions: ['.nghaml']
        env.register_mime_type 'text/ng-slim', extensions: ['.ngslim']
        env.register_transformer 'text/ng-slim', 'application/javascript', AngularRails4Templates::SlimProcessor
        env.register_transformer 'text/ng-haml', 'application/javascript', AngularRails4Templates::HamlProcessor
        env.register_transformer 'text/ng-html', 'application/javascript', AngularRails4Templates::Processor
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
