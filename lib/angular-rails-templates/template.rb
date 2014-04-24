require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < ::Tilt::Template
    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    def self.default_mime_type
      'application/javascript'
    end

    def prepare
      @template = Tilt.new(file) { data }
      @file = file[/(.+\.html)/]
    end

    def evaluate(scope, locals, &block)
      locals[:html] = @template.render
      locals[:angular_template_name] = logical_template_path(scope)
      locals[:source_file] = "#{scope.pathname}".gsub(/^#{Rails.root}\//,'')
      locals[:angular_module] = configuration.module_name

      AngularJsTemplateWrapper.render(nil, locals)
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

