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

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
  end

end
