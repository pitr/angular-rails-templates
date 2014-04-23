require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < Tilt::Template
    JsTemplate = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    def self.default_mime_type
      'application/javascript'
    end

    def prepare ; end

    def evaluate(scope, locals, &block)
      template = case File.extname(file)
               when HAML_EXT then HamlTemplate.new(self)
               when SLIM_EXT then SlimTemplate.new(self)
               else
                 BaseTemplate.new(self)
               end

      JsTemplate.render Object.new,
                        angular_module: configuration.module_name,
                           source_path: file.gsub(/^#{Rails.root}\//,''),
                                  name: logical_template_path(scope),
                                  html: template.render
    end

    protected

    def logical_template_path(scope)
      path = scope.logical_path.gsub /^#{configuration.ignore_prefix}/, ''
      "#{path}.html"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end

  end
end

