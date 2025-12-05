module RubyLLM
  module Monitoring
    class ApplicationRecord < ::ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
