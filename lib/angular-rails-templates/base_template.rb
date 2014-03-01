require 'forwardable'

module AngularRailsTemplates
  BaseTemplate = Struct.new(:context) do
    extend Forwardable

    def_delegators :context, :file, :data, :require_template_library

    def initialize_engine ; end

    def render
      initialize_engine
      engine.render
    end

    protected

    NoEngine = Struct.new(:data) do
      def render
        data
      end
    end

    def engine
      @engine ||= NoEngine.new(data)
    end
  end
end

