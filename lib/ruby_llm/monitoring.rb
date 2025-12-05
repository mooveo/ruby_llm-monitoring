require "groupdate"
require "ruby_llm"
require "ruby_llm/monitoring/version"
require "ruby_llm/monitoring/engine"

require "ruby_llm/chat"

module RubyLLM
  module Monitoring
    autoload :EventSubscriber, "ruby_llm/monitoring/event_subscriber"

    mattr_accessor :importmap, default: Importmap::Map.new
  end
end
