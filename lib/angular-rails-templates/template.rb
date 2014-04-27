require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < ::Tilt::Template
    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    def self.default_mime_type
      'application/javascript'
    end

    def prepare
      # this method is mandatory on Tilt::Template subclasses
    end

    def evaluate(scope, locals, &block)
      # to_json has quirky behavior in different versions of Rails
      locals[:html] = JSON.generate(data.chomp, quirks_mode: true)
      locals[:angular_template_name] = logical_template_path(scope)
      locals[:source_file] = "#{scope.pathname}".sub(/^#{Rails.root}\//,'')
      locals[:angular_module] = configuration.module_name

      AngularJsTemplateWrapper.render(scope, locals)
    end

    private

    def logical_template_path(scope)
      path = scope.logical_path.sub /^#{configuration.ignore_prefix}/, ''
      "#{path}.html"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end

  end
end

