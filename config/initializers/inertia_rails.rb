# frozen_string_literal: true

InertiaRails.configure do |config|
  # Set the default version of your frontend assets
  # This can be a string, a lambda, or anything that responds to `.call`
  config.version = ViteRuby.digest if defined?(ViteRuby)

  # Set the default component to render when a component is not found
  # config.default_render = true

  # Enable/disable deep transformation of props (converts Ruby objects to JS-friendly format)
  config.deep_merge_shared_data = true

  # Set the default layout
  config.layout = "application"
end
