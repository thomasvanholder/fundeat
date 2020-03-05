module BeforeFilterPatch
  extend ActiveSupport::Concern

  included do
    class << self
      alias_method :before_filter, :before_action
    end
  end
end

# config/initializers/application_controller_renderer.rb
require "before_filter_patch"

ActiveSupport::Reloader.to_prepare do
  ActionController::Base.send(:include, BeforeFilterPatch)
end
