require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template
    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    def self.default_mime_type
      'application/javascript'
    end

    def initialize(file, &block)
      @template = Tilt.new file, &block
    end

    def render(context, locals = {})
      locals[:html] = @template.render
      locals[:angular_template_name] = logical_template_path(context)
      locals[:source_file] = "#{context.pathname}".gsub(/^#{Rails.root}\//,'')
      locals[:angular_module] = configuration.module_name
      # locals[:context] = context
      AngularJsTemplateWrapper.render(nil, locals)
    end

    private

    def logical_template_path(context)
      path = context.logical_path.gsub /^#{configuration.ignore_prefix}/, ''
      "#{path}.html"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end

  end
end

