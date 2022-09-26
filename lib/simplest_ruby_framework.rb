require 'pathname'
require_relative 'simplest_ruby_framework/application'

module SimplestRubyFramework

  class << self
    def application
      Application.instance
    end

    def root
      Pathname.new(File.expand_path('..', __dir__))
    end
  end

end
