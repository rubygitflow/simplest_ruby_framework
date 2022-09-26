require 'yaml'
require 'singleton'
require 'sequel'
require_relative 'router'
require_relative 'controller'

module SimplestRubyFramework
  class Application

    include Singleton

    attr_reader :db

    def initialize
      @router = Router.new
      @db = nil
    end

    def bootstrap!
      setup_database
      require_app
      require_routes
    end

    def routes(&block)
      @router.instance_eval(&block)
    end

    def call(env)
      route = @router.route_for(env)
      if route.nil?
        url_not_found_response
      else
        controller = route.controller.new(env)
        action = route.action
        format = route.format
        make_response(controller, action, format)
      end
    end

    private

    def require_app
      Dir["#{SimplestRubyFramework.root}/app/**/*.rb"].each { |file| require file }
    end

    def require_routes
      require SimplestRubyFramework.root.join('config/routes')
    end

    def setup_database
      database_config = YAML.load_file(SimplestRubyFramework.root.join('config/database.yml'))
      database_config['database'] = SimplestRubyFramework.root.join(database_config['database'])
      @db = Sequel.connect(database_config)
    end

    def make_response(controller, action, format)
      controller.make_response(action, format)
    rescue IndexError
      unprocessable_entity_response
    rescue NotImplementedError
      not_implemented_response
    end

    def url_not_found_response
      Rack::Response.new(
        ['URL not found'],
        404,
        {"Content-Type" => "text/plain"}
      ).finish
    end

    def unprocessable_entity_response
      Rack::Response.new(
        ['Unprocessable Entity'],
        422,
        {"Content-Type" => "text/plain"}
      ).finish
    end

    def not_implemented_response
      Rack::Response.new(
        ['Not Implemented'],
        501,
        {"Content-Type" => "text/plain"}
      ).finish
    end

  end
end
