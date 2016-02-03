require 'angular-rails-templates/compact_javascript_escape'

module AngularRailsTemplates
  class Processor

    AngularJsTemplateWrapper = Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    include CompactJavaScriptEscape

    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def self.cache_key
      instance.cache_key
    end

    attr_reader :cache_key, :config

    def config
      Rails.configuration.angular_templates
    end

    def initialize(options = {})
      @cache_key = [self.class.name, VERSION, options].freeze
    end

    def template_name(name)
      path = name.sub /^(#{config.ignore_prefix.join('|')})/, ''
      "#{path}.#{config.extension}"
    end

    def call(input)
      locals = {}
      locals[:angular_template_name] = template_name(input[:name])
      locals[:angular_module] = config.module_name
      locals[:source_file] = "#{input[:filename]}".sub(/^#{Rails.root}\//,'')

      locals[:html] = escape_javascript(input[:data].chomp)

      if config.inside_paths.any? { |folder| input[:filename].match(folder.to_s) }
        AngularJsTemplateWrapper.render(nil, locals)
      else
        input[:data]
      end
    end
  end
end
