require_relative 'router/route'

module SimplestRubyFramework
  class Router

    def initialize
      @routes = []
    end

    def get(path, route_point, format)
      add_route(:get, path, route_point, format)
    end

    def post(path, route_point, format)
      add_route(:post, path, route_point, format)
    end

    def route_for(env)
      # https://rubydoc.info/github/rack/rack/file/SPEC.rdoc
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']

      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, route_point, format)
      route_point = route_point.split('#')
      controller = controller_from_string(route_point[0])
      action = route_point[1]
      route = Route.new(method, path, controller, action, format)

      @routes.push(route)
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.camelize}Controller") # capitalize
    end

  end
end
