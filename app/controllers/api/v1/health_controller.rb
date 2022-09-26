module Api
  module V1
    class HealthController < SimplestRubyFramework::Controller

      def ping
        @time = Time.now
      end
    end
  end
end 
