module AngularRailsTemplates
  class SlimTemplate < Template
    def initialize_engine
      require_template_library 'slim'
    end

    def prepare
      @engine = Slim::Template.new(file)
    end
  end
end

