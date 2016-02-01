require 'angular-rails-templates/compact_javascript_escape'

module AngularRailsTemplates
  class Processor

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

    def render_html(input)
      escape_javascript input[:data].chomp
    end

    def template_name(name)
      path = name.sub /^(#{config.ignore_prefix.join('|')})/, ''
      "#{path}.html"
    end

    def call(input)
      angular_template_name = template_name(input[:name])
      angular_module = config.module_name
      html = render_html(input)
      source_file = "#{input[:filename]}".sub(/^#{Rails.root}\//,'')
      erb = ERB.new(File.read("#{File.dirname __FILE__}/javascript_template.js.erb"))

      result = erb.result binding

      result
    end
  end
end
