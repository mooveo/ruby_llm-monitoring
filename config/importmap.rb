pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@stimulus-components/auto-submit", to: "https://ga.jspm.io/npm:@stimulus-components/auto-submit@6.0.0/dist/stimulus-auto-submit.mjs"
pin "apexcharts", to: "https://ga.jspm.io/npm:apexcharts@4.3.0/dist/apexcharts.common.js"

pin "application", to: "ruby_llm/monitoring/application.js", preload: true
pin_all_from RubyLLM::Monitoring::Engine.root.join("app/javascript/ruby_llm/monitoring/controllers"), under: "controllers", to: "ruby_llm/monitoring/controllers"
