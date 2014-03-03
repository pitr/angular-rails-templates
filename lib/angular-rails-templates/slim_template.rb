module AngularRailsTemplates
  class SlimTemplate < BaseTemplate
    def initialize_engine
      require_template_library 'slim'
    end

    protected

    def engine
      @engine ||= Slim::Template.new(file)
    end
  end
end

