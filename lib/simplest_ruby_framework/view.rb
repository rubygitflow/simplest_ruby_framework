require 'erb'
require 'rb_json5'

module SimplestRubyFramework
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env, format)
      @env = env
      @format = format
    end

    def render(binding)
      case @format
      when :erb
        template = template_erb_path
        ERB.new(template).result(binding)
      when :jrb
        template = require_json_route
        p "template=#{template.inspect}"
        jr = binding.eval('"' + template + '"')
        p "jr=#{jr.inspect}"
        RbJSON5.parse(jr)
      end
    end

    private

    def controller
      @env['simplest_ruby_framework.controller']
    end

    def action
      @env['simplest_ruby_framework.action']
    end

    def template
      @env['simplest_ruby_framework.template']
    end

    def template_erb_path
      File.read( view_template_path('.html.erb') )
    end

    def require_json_route
      File.read( view_template_path('.json.jrb') )
    end

    def view_template_path(format_description)
      path = template || [controller.name, action].join('/')
      @env['simplest_ruby_framework.template_path'] = File.join(VIEW_BASE_PATH, "#{path}"+format_description)
      SimplestRubyFramework.root.join(@env['simplest_ruby_framework.template_path'])
    end

  end
end
