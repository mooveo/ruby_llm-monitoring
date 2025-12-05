module RubyLLM
  module Monitoring
    class ApplicationController < ActionController::Base
      private

      def filter_param
        {}
      end
      helper_method :filter_param
    end
  end
end
