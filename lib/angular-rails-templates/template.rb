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
angular.module(#{module_name.inspect}, []).run(["$templateCache",function($templateCache) {
  $templateCache.put(#{logical_template_path.inspect}, #{data.to_json});
}]);

if (typeof window.AngularRailsTemplates === 'undefined') {
  window.AngularRailsTemplates = [];
}
window.AngularRailsTemplates.push(#{module_name.inspect});
      EOS
    end

    private
    def logical_template_path(scope)
      "#{scope.logical_path}.#{basename.split(".")[1]}"
    end

    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end
