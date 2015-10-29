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

  def mowalontest
    @mowalontest ||= User.create(name: "MowAlon Test",
                screen_name: "MowAlonTest",
                uid: 4060312512,
                oauth_token: ENV["mowalontest_token"],
                oauth_token_secret: ENV["mowalontest_secret"])
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
          user_id: "4060312512",
          name: "MowAlon Test",
          screen_name: "MowAlonTest",
        }
      },
      credentials: {
        token: ENV["mowalontest_token"],
        secret: ENV["mowalontest_secret"]
      }
    })
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
  end

end
