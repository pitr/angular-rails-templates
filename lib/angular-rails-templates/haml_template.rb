module AngularRailsTemplates
  class HamlTemplate < BaseTemplate
    def initialize_engine
      require_template_library 'haml'
    end

    protected

    def engine
      @engine ||= Haml::Engine.new data, ugly: true
    end
  end
end

