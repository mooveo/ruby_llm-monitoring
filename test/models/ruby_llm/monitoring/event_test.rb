require "test_helper"

module RubyLLM::Monitoring
  class EventTest < ActiveSupport::TestCase
    test "calculates cost for cloud provider" do
      event = Event.create!(
        payload: {
          "provider" => "gemini",
          "model" => "gemini-2.5-flash",
          "input_tokens" => 1000,
          "output_tokens" => 500
        }
      )

      assert_not_nil event.cost
      assert event.cost >= 0.0
    end

    test "sets cost to zero for local provider" do
      event = Event.create!(
        payload: {
          "provider" => "ollama",
          "model" => "gemma3",
          "input_tokens" => 1000,
          "output_tokens" => 500
        }
      )

      assert_equal 0.0, event.cost
    end

    test "sets cost to zero when tokens are nil" do
      event = Event.create!(
        payload: {
          "provider" => "gemini",
          "model" => "gemini-2.5-flash"
        }
      )

      assert_equal 0.0, event.cost
    end
  end
end
