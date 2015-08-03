require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Symporter
  class Application < Rails::Application
  config.assets.precompile += [
      'carousel.css.scss'
    ]
    config.assets.precompile += [
      'bootstrap-theme.min.css.scss'
    ]
    config.assets.precompile += [
      'custom.css.scss'
    ]
    config.assets.precompile += [
      'bootstrap.min.js.erb'
    ]
    config.assets.precompile += [
      'jquery.min.js.erb'
    ]
    config.assets.precompile += [
      'docs.min.js.erb'
    ]
      config.assets.precompile += [
      'ie10-viewport-bug-workaround.js'
    ]
    
    
  end
end
