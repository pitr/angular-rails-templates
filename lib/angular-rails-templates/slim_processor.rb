require 'angular-rails-templates/compact_javascript_escape'
require 'slim'

module AngularRailsTemplates
  class SlimProcessor < Processor

    include CompactJavaScriptEscape

    def render_html(input)
      template = input[:data]
      output = Slim::Template.new { template }.render
      escape_javascript output
    end
  end
end