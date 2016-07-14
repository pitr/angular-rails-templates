require 'angular-rails-templates/compact_javascript_escape'
require 'delegate'

module AngularRailsTemplates
  class Processor

    AngularJsTemplateWrapper = ::Tilt::ERBTemplate.new "#{File.dirname __FILE__}/javascript_template.js.erb"

    # Temporary wrapper, old one is deprecated by Sprockets 4.
    # TODO replace.
    # https://github.com/ai/autoprefixer-rails/blob/master/lib/autoprefixer-rails/sprockets.rb
    class Tilt < Delegator
      def initialize(klass)
        @klass = klass
      end

      def __getobj__
        @klass
      end

      def self.install(env, suffix, ext)
        env.register_mime_type   "text/ng-#{suffix}", extensions: [".#{ext}.#{suffix}"]
        env.register_transformer "text/ng-#{suffix}", 'text/ng-html', self[suffix]
      end

      def self.[](ext)
        self.new(::Tilt[ext])
      end

      def call(input)
        filename = input[:filename]
        data     = input[:data]
        context  = input[:environment].context_class.new(input)

        data = @klass.new(filename) { data }.render(context, {})
        context.metadata.merge(data: data.to_str)
      end
    end

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

    attr_reader :cache_key

    def config
      Rails.configuration.angular_templates
    end

    def initialize(options = {})
      @cache_key = [self.class.name, VERSION, options].freeze
    end

    def template_name(name)
      path = name.sub(/^#{config.ignore_prefix.join('|')}/, '')
      "#{path}.#{config.extension}"
    end

    def call(input)
      file_path = Pathname.new(input[:filename]).relative_path_from(Rails.root).to_s

      unless config.inside_paths.any? { |folder| file_path.match(folder.to_s) }
        return input[:data]
      end

      locals = {}
      locals[:angular_template_name] = template_name(input[:name])
      locals[:angular_module] = config.module_name
      locals[:source_file] = "#{input[:filename]}".sub(/^#{Rails.root}\//,'')

      locals[:html] = escape_javascript(input[:data].chomp)

      AngularJsTemplateWrapper.render(nil, locals)
    end
  end
end
