module RubyLLM
  class Chat
    alias_method :original_complete, :complete
    def complete(&)
      ActiveSupport::Notifications.instrument(
        "complete_chat.ruby_llm",
        { provider: @provider.slug, model: @model.id, streaming: block_given? }
      ) do |payload|
        original_complete(&).tap do |response|
          %i[input_tokens output_tokens cached_tokens cache_creation_tokens].each do |field|
            value = response.public_send(field)
            payload[field] = value unless value.nil?
          end
          payload[:tool_calls] = response.tool_calls.size if response.tool_call?
        end
      end
    end
  end
end
