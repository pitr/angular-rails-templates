require 'slim'
require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    def prepare; end

    def evaluate(scope, locals, &block)
      module_name           = configuration.module_name
      logical_template_path = logical_template_path(scope)

      <<-EOS
window.AngularRailsTemplates || (window.AngularRailsTemplates = angular.module(#{module_name.inspect}, []));

window.AngularRailsTemplates.run(["$templateCache",function($templateCache) {
  $templateCache.put(#{logical_template_path.inspect}, #{content.to_json});
}]);
      EOS
    end

    private

    def content
      case File.extname(file)
      when /ast/ then Slim::Template.new(file).render
      else data
      end
    end

    def logical_template_path(scope)
      path = scope.logical_path
      path.gsub!(Regexp.new("^#{configuration.ignore_prefix}"), "")
      ext = basename.split(".")[1]
      "#{path}.#{ext}"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end
