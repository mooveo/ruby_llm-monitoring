require "groupdate"
require "ruby_llm"
require "ruby_llm/instrumentation"
require "ruby_llm/monitoring/version"
require "ruby_llm/monitoring/engine"

module RubyLLM
  module Monitoring
    autoload :EventSubscriber, "ruby_llm/monitoring/event_subscriber"

    mattr_accessor :importmap, default: Importmap::Map.new
  end
end
