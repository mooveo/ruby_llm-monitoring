module RubyLLM::Monitoring
  module MetricsHelper
    def resolution_options
      { "1 minute" => 1, "10 minutes" => 10, "1 hour" => 60 }
    end
  end
end
