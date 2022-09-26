require 'http'
require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:log_file] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    log(env, status, headers)
    Rack::Response.new(body,status,headers).finish
  end

  private

  def log(env, status, headers)
    @logger.info <<~LOG
      Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}
      Handler: #{env['simplest_ruby_framework.controller'].class.name} #{env['simplest_ruby_framework.action']}
      Parameters: #{env['simplest_ruby_framework.params']}
      # https://www.rubydoc.info/gems/http/HTTP/Response/Status
      Response: #{status} #{HTTP::Response::Status::REASONS[status]} \
      [#{headers['Content-Type']}] #{env['simplest_ruby_framework.template_path']}
    LOG
  end
end
