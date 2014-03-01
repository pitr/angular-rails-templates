module AngularRailsTemplates
  class GenericTemplate < Template
    NoEngine = Struct.new(:data) do
      def render
        data
      end
    end

    def prepare
      @engine = NoEngine.new(data)
    end
  end
end

