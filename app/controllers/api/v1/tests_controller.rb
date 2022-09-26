module Api
  module V1
    class TestsController < SimplestRubyFramework::Controller

      def index
        @time = Time.now
      end
    end
  end
end 
