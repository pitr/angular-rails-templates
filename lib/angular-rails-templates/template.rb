require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template
    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    def self.default_mime_type
      'application/javascript'
    end

    def initialize(file, &block)
      @file = file
      @template = Tilt.new file, &block
    end

    def render(context, locals = {})
      locals[:html] = @template.render
      locals[:angular_template_name] = logical_template_path(context)
      AngularJsTemplateWrapper.render(self, locals)
    end

    # methods availible to the js template

    def angular_module
      configuration.module_name
    end

    def source_file
      @file.gsub(/^#{Rails.root}\//,'')
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

