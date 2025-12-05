Rails.application.routes.draw do
  mount RubyLLM::Monitoring::Engine => "/ruby_llm-monitoring"
end
