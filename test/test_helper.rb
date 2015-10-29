require "simplecov"
SimpleCov.start("rails")
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'webmock'
require 'vcr'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_alon
    User.create(name: "Alon Waisman",
                screen_name: "MowAlon",
                uid: 150688890,
                oauth_token: ENV["alon_token"],
                oauth_token_secret: ENV["alon_secret"])
  end

  def stub_omniauth
    # First, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "150688890",
          name: "Alon Waisman",
          screen_name: "MowAlon",
        }
      },
      credentials: {
        token: ENV["alon_token"],
        secret: ENV["alon_secret"]
      }
    })
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
  end

end
