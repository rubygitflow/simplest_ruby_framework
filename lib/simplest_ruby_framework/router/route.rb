module SimplestRubyFramework
  class Router
    class Route
      attr_reader :controller, :action, :format

      def initialize(method, path, controller, action, format)
        @method = method
        @path = regular_path(path)
        @controller = controller
        @action = action
        @format = format
      end

      def match?(method, path)
        @method == method && path.match(@path)
      end

      private

      def regular_path(path)
        path.gsub!(/^/, '^')
        path.gsub!(/$/, '$')
        path.gsub!(/\//, '\/')
        path.gsub!(/:id\$/, '\d$') if path.end_with?('/:id$')
        path
      end
    end
  end
end
