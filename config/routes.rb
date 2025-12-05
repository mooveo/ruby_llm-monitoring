RubyLLM::Monitoring::Engine.routes.draw do
  resources :metrics, only: :index
  root to: "metrics#index"
end
