require_relative 'config/environment'
require_relative 'lib/simplest_ruby_framework/logger'

run SimplestRubyFramework.application
use AppLogger, log_file: File.expand_path('log/app.log', __dir__)
