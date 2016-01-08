if defined? Slim
  require 'angular-rails4-templates/compact_javascript_escape'
  require 'slim'

  module AngularRails4Templates
    class SlimProcessor < Processor

      include CompactJavaScriptEscape

      def render_html(input)
        template = input[:data]
        output = Slim::Template.new { template }.render
        escape_javascript output
      end
    end
  end
end
