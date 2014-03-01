module AngularRailsTemplates
  class HamlTemplate < Template
    def initialize_engine
      require_template_library 'haml'
    end

    def prepare
      @engine = Haml::Engine.new(data)
    end
  end
end

