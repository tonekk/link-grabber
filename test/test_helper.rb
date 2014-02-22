ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/pride"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Helper Methods
def sign_in_user
  u = Fabricate(:user)
  sign_in :user, u
end

def sign_in_admin
  a = Fabricate(:admin)
  sign_in :admin, a
end

class ActiveSupport::TestCase
  setup do
    Mongoid.default_session.collections.each { |coll| coll.drop }
    Mongoid.models.each {|m| m.create_indexes}
  end
end

class ActionController::TestCase
  include Rails.application.routes.url_helpers
  include Devise::TestHelpers
end
