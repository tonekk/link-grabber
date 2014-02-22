require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)

module LinkGrabber
  class Application < Rails::Application
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :de
    config.i18n.fallbacks = [:en]

    config.generators do |g|
      g.orm :mongoid
    end
  end
end
