require 'json'

module AngularRailsTemplates
  class Template < ::Tilt::Template
    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"
    @@compressor = nil

    def self.default_mime_type
      'application/javascript'
    end

    # this method is mandatory on Tilt::Template subclasses
    def prepare
      if configuration.htmlcompressor
        @data = compress data
      end

      # to_json has quirky behavior in different versions of Rails
      @html_json = JSON.generate(data.chomp, quirks_mode: true)
    end

    def evaluate(scope, locals, &block)
      locals[:html] = @html_json
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

    def compress html
      unless @@compressor
        @@compressor = if configuration.htmlcompressor.is_a? Hash
          HtmlCompressor::Compressor.new(configuration.htmlcompressor)
        else
          HtmlCompressor::Compressor.new
        end
      end
      @@compressor.compress(html)
    end
  end
end

