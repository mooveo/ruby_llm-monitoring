require "test_helper"

module RubyLLM::Monitoring
  class EventSubscriberTest < ActiveSupport::TestCase
    test "creates event when chat is completed" do
      VCR.use_cassette "event_subscriber_test_creates_event_when_chat_is_completed" do
        chat = RubyLLM.chat provider: "ollama", model: "gemma3"

        assert_difference "Event.count", 1 do
          chat.ask "what's 1 + 1?"
        end
      end
    end
  end
end
