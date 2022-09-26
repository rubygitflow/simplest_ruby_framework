require_relative 'view'

module SimplestRubyFramework
  class Controller
      # https://www.geeksforgeeks.org/http-headers-content-type/
      FORMATS = {
        erb: 'text/html',
        jrb: 'application/json',
      }

    attr_reader :name, :request, :response, :format

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @request.env['simplest_ruby_framework.params'] = params.fetch('id', nil)
    end

    def make_response(action, format)
      @request.env['simplest_ruby_framework.controller'] = self
      @request.env['simplest_ruby_framework.action'] = action
      @format = format
      view_format = FORMATS.fetch(format, nil)

      set_default_headers(view_format)
      send(action)
      write_response

      @response.finish
    end

    # https://rubydoc.info/github/rack/rack/file/SPEC.rdoc
    def set_status(code)
      @response.status = code
    end

    def set_headers(headers)
      headers.each { |key, value| @response[key] = value }
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].underscore # downcase
    end

    def set_default_headers(view_format)
      if view_format
        @response['Content-Type'] = view_format
      elsif @response['Content-Type'].blank?
        @response['Content-Type'] = 'text/html'
      end
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env, format).render(binding)
    end

    def params
      @request.params
    end

    def render(template)
      @request.env['simplest_ruby_framework.template'] = template
    end
    
    def record
      @request.path_info.gsub(/[^\d]/, '')
    end
  end
end
