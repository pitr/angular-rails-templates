require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template
    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    def self.default_mime_type
      'application/javascript'
    end

    def initialize(file, &block)
      @data = block.call
      @file = file
      @template =
      case File.extname(file)
        when HAML_EXT
          Tilt::HamlTemplate.new file
        when SLIM_EXT
          Slim::Template.new file
        else
          Tilt.new file, &block
      end
    end

    def render(context, locals = {})
      AngularJsTemplateWrapper.render self, html: @template.render, angular_template_name: logical_template_path(context)
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

