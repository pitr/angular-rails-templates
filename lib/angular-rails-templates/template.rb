require 'sprockets'
require 'sprockets/engines'

module AngularRailsTemplates
  class Template < Tilt::Template
    def self.default_mime_type
      'application/javascript'
    end

    def prepare; end

    def evaluate(scope, locals, &block)
      key         = file.split('/').last
      module_name = "#{configuration.module_name}-#{key.split('.')[0...-1].join('.')}"

      <<-EOS
angular.module(#{module_name.inspect}, []).run(function($templateCache) {
  $templateCache.put(#{key.inspect}, #{data.to_json});
});

if (typeof window.AngularRailsTemplates === 'undefined') {
  window.AngularRailsTemplates = [];
}
window.AngularRailsTemplates.push(#{module_name.inspect});
      EOS
    end

    private
    def configuration
      ::Rails.configuration.angular_templates
    end
  end
end
