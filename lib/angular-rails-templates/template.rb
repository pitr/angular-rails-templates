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
window["#{module_name}"] = window["#{module_name}"] || angular.module("#{module_name}", []);

window["#{module_name}"].run(["$templateCache", function($templateCache) {
  $templateCache.put(#{logical_template_path.inspect}, #{data.to_json});
}]);
      EOS
    end

    private

    def logical_template_path(scope)
      logical_path = "#{scope.logical_path}.#{basename.split(".")[1]}"

      if logical_path.start_with?(templates_dir)
        logical_path = logical_path[ (templates_dir.length + 1) ..-1]
      end

      logical_path
    end

    def templates_dir
      dir = configuration.templates_dir
      if dir.end_with? "/"
        dir = dir[0..-2]
      end
      dir
    end

    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end
